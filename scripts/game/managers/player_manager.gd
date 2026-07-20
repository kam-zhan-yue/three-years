class_name PlayerManager
extends Node3D

@onready var spawner := %Spawner as Spawner
@onready var alex_spawn := %AlexSpawn as Marker3D
@onready var wato_spawn := %WatoSpawn as Marker3D

signal server_players_loaded
var server_players: Dictionary[int, Game.Character] = {}
var server_loaded_players := []

func _ready() -> void:
	spawner.spawned.connect(_client_spawn_player)

func reset_players() -> void:
	server_players = {}
	server_loaded_players = []
	spawner.despawn_all()

func server_init_player(id: int, character: Game.Character) -> void:
	if !multiplayer.is_server(): return
	var player := spawner.spawn_player(id, character)
	Global.debug("Server spawning %s" % player.name)
	server_players[id] = character

func server_register_player(character: Game.Character) -> void:
	Global.print("Character spawned: %s" % character)
	server_loaded_players.append(character)
	if len(server_loaded_players) == 2:
		server_players_loaded.emit()

func server_activate_all(active: bool) -> void:
	Server.set_player_active(Game.Character.Wato, active)
	Server.set_player_active(Game.Character.Alex, active)

func server_activate(character: Game.Character, active: bool) -> void:
	Server.set_player_active(character, active)

func client_activate(active: bool) -> void:
	if active:
		Client.game.player.activate()
	else:
		Client.game.player.deactivate()

func server_despawn_players() -> void:
	spawner.despawn_all()
	pass

# Called client-side
func _client_spawn_player(node: Node) -> void:
	var player := node as Player
	Global.debug("Spawned %s" % player.name)
	if player.name == str(Global.id()):
		var spawn := alex_spawn if Client.game.character == Game.Character.Alex else wato_spawn
		player.global_position = spawn.global_position
		player.global_rotation = spawn.global_rotation
		Client.register_player(player)


func server_set_anim(anim: Player.AnimState) -> void:
	Client.set_anim(anim)

func client_set_anim(anim: Player.AnimState) -> void:
	Client.game.player.client_set_anim(anim)
