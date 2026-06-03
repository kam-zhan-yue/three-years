class_name GameManager
extends Node

var counter := 0.0
var timer := 0

var game_client: GameClient
var game_server: GameServer

@onready var spawner := %Spawner as Spawner

func _ready() -> void:
	Client.started.connect(_init_client)
	Server.started.connect(_init_server)
	multiplayer.connected_to_server.connect(_on_connected)
	multiplayer.peer_connected.connect(spawn_player)
	spawner.spawned.connect(_spawned)

func _init_client() -> void:
	game_client = GameClient.new()
	Client.init_game(game_client)

func _init_server() -> void:
	game_server = GameServer.new()
	Server.init_game(game_server)

func _on_connected() -> void:
	Server.register(Global.id(), "oh yeah!")

# Spawns players server-side
func spawn_player(id: int) -> void:
	if !multiplayer.is_server(): return
	var player := spawner.spawn_player(id)
	Global.print("Server spawning %s" % player.name)

# Called clent-side
func _spawned(node: Node) -> void:
	var player := node as Player
	Global.print("Spawned %s" % player.name)
	if player.name == str(Global.id()):
		game_client.add_player(player)
