class_name GameServer
extends Node

var game := Game.new()

# Synced Values / Game State
var current_event: GameEvent
var server_players: Dictionary[int, Game.Character] = {}
var server_loaded_players := []
var played_dialogue_events: Dictionary[Dialogue.Event, bool] = {}

func _init() -> void:
	server_players = {}
	server_loaded_players = []
	played_dialogue_events = {}
	for event in game.EVENTS.values():
		event.ended.connect(_end_event)

func add_player(id: int, character: Game.Character) -> void:
	Services.players.server_init_player(id, character)
	send_update()

func get_player_id(character: Game.Character) -> int:
	for id in server_players:
		if server_players[id] == character:
			return id
	return 1

func get_character(id: int) -> Game.Character:
	return server_players[id]

func send_update() -> void:
	Client.update_game(get_state())

func get_state() -> Game.GameState:
	var state := Game.GameState.new()
	state.players = server_players
	return state

var flow := 0

func start_game() -> void:
	Global.print("Started Game. Waiting for players ...")
	await Services.players.server_players_loaded
	Global.print("Players loaded. Entering first event.")
	enter_flow(0)

# ============FLOW HANDLING=================
func enter_flow(index: int) -> void:
	flow = index
	if flow >= len(game.FLOW):
		return # end flow here
	var event := game.FLOW[index]
	Global.print("Entering %s" % Global.EVENT_NAME[event])
	start_event(event)

func next_flow() -> void:
	enter_flow(flow + 1)

# ============EVENT HANDLING=================
func start_event(event: Game.Event) -> void:
	if event not in game.EVENTS: return
	current_event = game.EVENTS[event]
	current_event.start()
	Client.start_game_event(event)

func _end_event() -> void:
	Global.debug("Ending Event.")
	next_flow()

# ============DIALOGUE HANDLING=================
func skip_dialogue_animation(line: Dialogue.Line) -> void:
	Services.dialogue.server_skip_dialogue_animation(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	Services.dialogue.server_continue(line)

# ============INTERACT HANDLING=================
func start_interacting(interact_id: String) -> void:
	# TODO: This is a super hack :D
	if interact_id.contains("Derek") and _try_play_dialogue_event(Game.DialogueEvent.Derek):
		pass
	elif interact_id.contains("Ukelele") and _try_play_dialogue_event(Game.DialogueEvent.Ukelele):
		pass
	else:
		Global.print("Server Interact Start %s" % interact_id)
		Services.interact.server_interact_start(interact_id)

func stop_interacting(interact_id: String) -> void:
	Services.interact.server_interact_stop(interact_id)

func complete_interact(interact_id: String) -> void:
	# TODO: Another super hack :D
	if interact_id.contains("Derek"):
		_try_play_dialogue_event(Game.DialogueEvent.DerekCleaned)
	if interact_id.contains("Laundry"):
		_try_play_dialogue_event(Game.DialogueEvent.LaundryCleaned)
	Client.complete_interaction(interact_id)
	Services.interact.server_check_all_completed()

# ============SHELF HANDLING=================
func select_ingredient(type: String) -> void:
	Services.shelf.server_select(type)

# ============PLACEMENT HANDLING=================
func confirm_placement(type: Placement.Type) -> void:
	Services.placement.server_confirm(type)

func _try_play_dialogue_event(event: Game.DialogueEvent) -> bool:
	if event not in game.DIALOGUE_EVENTS:
		Global.error("Couldn't find %s in DIALOGUE_EVENTS")
		return false
	if event in played_dialogue_events:
		return false
	played_dialogue_events[event] = true
	Services.dialogue.server_start(game.DIALOGUE_EVENTS[event])
	return true
