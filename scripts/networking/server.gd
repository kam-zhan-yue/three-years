extends Node

var peer: ENetMultiplayerPeer
var game: GameServer

signal started
signal player_joined(id: int)

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_connected)

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(Global.PORT)
	multiplayer.multiplayer_peer = peer
	Global.print("Starting Server")
	started.emit()

func init_game(g: GameServer) -> void:
	game = g

# When a peer connects, send them a game update to let them know how it is going
func _on_connected(_id: int) -> void:
	if !multiplayer.is_server(): return
	if !game: return
	game.send_update()


# Broadcasts a message to all clients
func broadcast(message: String) -> void:
	_broadcast_message.rpc_id(1, message)

@rpc("any_peer", "call_remote", "reliable")
func _broadcast_message(message: String) -> void:
	if !multiplayer.is_server(): return
	Client.print(message)

# Selects a character
func select_character(character: Game.Character) -> void:
	_select_character.rpc_id(1, Global.id(), character)

@rpc("any_peer", "call_remote", "reliable")
func _select_character(id: int, character: Game.Character) -> void:
	if !multiplayer.is_server(): return
	player_joined.emit(id)
	game.add_player(id, character)
