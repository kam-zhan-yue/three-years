extends Node

var peer: ENetMultiplayerPeer
var game: GameServer

signal started

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(Global.PORT)
	multiplayer.multiplayer_peer = peer
	Global.print("Starting Server")
	started.emit()

func init_game(g: GameServer) -> void:
	game = g

# Broadcasts a message to all clients
func broadcast(message: String) -> void:
	_broadcast_message.rpc_id(1, message)

@rpc("any_peer", "call_remote", "reliable")
func _broadcast_message(message: String) -> void:
	if !multiplayer.is_server(): return
	Client.print(message)

# Registers a player
func register(id: int, player: String) -> void:
	_register.rpc_id(1, id, player)

@rpc("any_peer", "call_remote", "reliable")
func _register(id: int, player: String) -> void:
	if !multiplayer.is_server(): return
	game.register_player(id, player)
