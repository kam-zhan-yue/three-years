class_name GameServer
extends Node

var game := Game.new()
var interact_manager: InteractManager
var dialogue_manager: DialogueManager

# Synced Values
var players: Dictionary[int, Game.Character] = {}
var current_event: GameEvent

func _init(im: InteractManager, dm: DialogueManager) -> void:
	interact_manager = im
	dialogue_manager = dm
	dialogue_manager.dialogue_ended.connect(_on_dialogue_ended)
	game.EVENTS[Game.Event.Clean].interact_manager = im
	for event in game.EVENTS.values():
		event.ended.connect(_end_event)

func add_player(id: int, character: Game.Character) -> void:
	players[id] = character
	send_update()

	if len(players) == 2:
		start()

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
	var event_type := Global.get_event_type(game.FLOW[index])
	var event := Global.get_event(game.FLOW[index])
	Global.print("Entering %s" % game.FLOW[index])
	if event_type == Game.EventType.Dialogue:
		start_dialogue_event(event)
	elif event_type == Game.EventType.Game:
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
func start_dialogue_event(event: Dialogue.Event) -> void:
	dialogue_manager.server_start(event)

func continue_dialogue(line: Dialogue.Line) -> void:
	dialogue_manager.server_continue(line)

func _on_dialogue_ended(_event: Dialogue.Event) -> void:
	next_flow()

# ============INTERACT HANDLING=================
func start_interacting(interact_id: String) -> void:
	interact_manager.server_interact_start(interact_id)

func stop_interacting(interact_id: String) -> void:
	interact_manager.server_interact_stop(interact_id)
