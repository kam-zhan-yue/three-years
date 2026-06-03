extends Node

var peer: ENetMultiplayerPeer
var game: GameClient

signal started

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Global.IP_ADDRESS, Global.PORT)
	multiplayer.multiplayer_peer = peer
	Global.print("Starting Client")
	started.emit()

func init_game(g: GameClient) -> void:
	game = g

# Prints a message to the console
func print(message: String) -> void:
	_print_message.rpc(message)

@rpc("authority", "call_remote", "reliable")
func _print_message(text: String) -> void:
	Global.print(text)

# Starts the game
func start_game() -> void:
	_start_game.rpc()

@rpc("authority", "call_remote", "reliable")
func _start_game() -> void:
	game.start_game()

