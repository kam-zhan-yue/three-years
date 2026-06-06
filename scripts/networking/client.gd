extends Node

var peer: ENetMultiplayerPeer
var game: GameClient

signal started
signal game_updated(state: Game.GameState)
signal dialogue_started(line: Dialogue.Line)
signal dialogue_continued(line: Dialogue.Line)
signal dialogue_ended()

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Global.IP_ADDRESS, Global.PORT)
	multiplayer.multiplayer_peer = peer
	Global.print("Starting Client")
	started.emit()

func init_game(g: GameClient) -> void:
	game = g

#==================Debugging====================
func print(message: String) -> void:
	_print_message.rpc(message)

@rpc("authority", "call_remote", "reliable")
func _print_message(text: String) -> void:
	Global.print(text)

#==================Game Events====================
func start_game_event(event: Game.Event) -> void:
	_start_game_event.rpc(event)

@rpc("authority", "call_remote", "reliable")
func _start_game_event(event: Game.Event) -> void:
	Global.debug("Starting Game Event: %s" % Global.EVENT_NAME[event])
	game.start_event(event)

#==================Dialogue====================
func start_dialogue(line: Dialogue.Line) -> void:
	_start_dialogue.rpc(inst_to_dict(line))

@rpc("authority", "call_remote", "reliable")
func _start_dialogue(line: Dictionary) -> void:
	var l := dict_to_inst(line) as Dialogue.Line
	Global.debug("Starting Dialogue: %s" % l.body)
	dialogue_started.emit(l)

func continue_dialogue(line: Dialogue.Line) -> void:
	_continue_dialogue.rpc(inst_to_dict(line))

@rpc("authority", "call_remote", "reliable")
func _continue_dialogue(line: Dictionary) -> void:
	var l := dict_to_inst(line) as Dialogue.Line
	Global.debug("Continuing Dialogue: %s" % l.body)
	dialogue_continued.emit(l)

func end_dialogue() -> void:
	_end_dialogue.rpc()

@rpc("authority", "call_remote", "reliable")
func _end_dialogue() -> void:
	dialogue_ended.emit()


#==================Game State====================
func update_game(state: Game.GameState) -> void:
	_update_game.rpc(inst_to_dict(state))

@rpc("authority", "call_remote", "reliable")
func _update_game(state: Dictionary) -> void:
	var game_state = dict_to_inst(state) as Game.GameState
	game_updated.emit(game_state)
	

#==================Character Select====================
func select_character(character: Game.Character) -> void:
	game.set_character(character)
	Server.select_character(character)

# Starts the game
func start_game() -> void:
	_start_game.rpc()

@rpc("authority", "call_remote", "reliable")
func _start_game() -> void:
	game.start_game()
		
#==================Interactions====================
func complete_interaction(interact_id: String) -> void:
	_complete_interaction.rpc(interact_id)

@rpc("authority", "call_remote", "reliable")
func _complete_interaction(interact_id: String) -> void:
	game.complete_interaction(interact_id)
