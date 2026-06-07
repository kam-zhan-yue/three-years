class_name GameManager
extends Node

var counter := 0.0
var timer := 0

var game_client: GameClient
var game_server: GameServer

@onready var spawner := %Spawner as Spawner
@onready var alex_spawn := %AlexSpawn as Marker3D
@onready var wato_spawn := %WatoSpawn as Marker3D
@onready var interact_manager = %InteractManager as InteractManager
@onready var dialogue_manager = %DialogueManager as DialogueManager
@onready var camera_manager = %CameraManager as CameraManager
@onready var ui = %UI as UI


func _ready() -> void:
	Services.ui = ui
	Services.interact = interact_manager
	Services.dialogue = dialogue_manager
	Services.camera = camera_manager

	Client.started.connect(_init_client)
	Server.started.connect(_init_server)
	spawner.spawned.connect(_spawned)
	Server.player_joined.connect(spawn_player)

func _init_client() -> void:
	game_client = GameClient.new()
	Client.init_game(game_client)

func _init_server() -> void:
	game_server = GameServer.new()
	Server.init_game(game_server)

# Spawns players server-side
func spawn_player(id: int) -> void:
	if !multiplayer.is_server(): return
	var player := spawner.spawn_player(id)
	Global.debug("Server spawning %s" % player.name)

# Called clent-side
func _spawned(node: Node) -> void:
	var player := node as Player
	Global.debug("Spawned %s" % player.name)
	if player.name == str(Global.id()):
		var spawn_pos := (
			alex_spawn.global_position 
			if game_client.character == Game.Character.Alex 
			else wato_spawn.global_position
		)
		player.global_position = spawn_pos
		game_client.set_player(player)
