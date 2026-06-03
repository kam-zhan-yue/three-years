extends Node

var peer: ENetMultiplayerPeer
var game: GameClient

signal started
signal game_updated(GameState)

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

# Update the game state
func update_game(state: GameState) -> void:
	_update_game.rpc(inst_to_dict(state))

@rpc("authority", "call_remote", "reliable")
func _update_game(state: Dictionary) -> void:
	var game_state = dict_to_inst(state) as GameState
	game_updated.emit(game_state)
	
# Selects the character
func select_character(character: Game.Character) -> void:
	game.set_character(character)
	Server.select_character(character)

# Starts the game
func start_game() -> void:
	_start_game.rpc()

@rpc("authority", "call_remote", "reliable")
func _start_game() -> void:
	game.start_game()


