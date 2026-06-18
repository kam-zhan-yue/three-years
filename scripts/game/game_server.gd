class_name GameServer
extends Node

var game := Game.new()

# Synced Values
var players: Dictionary[int, Game.Character] = {}
var current_event: GameEvent

func _init() -> void:
	for event in game.EVENTS.values():
		event.ended.connect(_end_event)

func add_player(id: int, character: Game.Character) -> void:
	players[id] = character
	send_update()

	if len(players) == 2:
		start()

func get_player_id(character: Game.Character) -> int:
	for id in players:
		if players[id] == character:
			return id
	return 1

func send_update() -> void:
	Client.update_game(get_state())

func get_state() -> Game.GameState:
	var state := Game.GameState.new()
	state.players = players
	return state

var flow := 0

func start() -> void:
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
func continue_dialogue(line: Dialogue.Line) -> void:
	Services.dialogue.server_continue(line)

# ============INTERACT HANDLING=================
func start_interacting(interact_id: String) -> void:
	Services.interact.server_interact_start(interact_id)

func stop_interacting(interact_id: String) -> void:
	Services.interact.server_interact_stop(interact_id)

# ============SHELF HANDLING=================
func select_ingredient(type: String) -> void:
	Services.shelf.server_select(type)

# ============PLACEMENT HANDLING=================
func confirm_placement(type: Placement.Type) -> void:
	Services.placement.server_confirm(type)
