class_name GameServer
extends Node

var game := Game.new()
var interact_manager: InteractManager

# Synced Values
var players: Dictionary[int, Game.Character] = {}
var current_event: GameEvent
var current_script: DialogueScript
var current_line := 0

func _init(im: InteractManager) -> void:
	interact_manager = im
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
	if event not in game.DIALOGUES: return
	current_script = game.DIALOGUES[event]
	current_line = 0
	var line := _get_current_line()
	if !line: return
	Client.start_dialogue(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	var current := _get_current_line()
	# If we are not at the current line, then don't progress
	if current.speaker != line.speaker or current.body != line.body: return

	current_line += 1
	var next_line := _get_current_line()
	if !next_line:
		end_dialogue()
	else:
		Global.debug("Next line is: %s" % next_line.body)
		Client.continue_dialogue(next_line)

func end_dialogue() -> void:
	Global.debug("Ending Dialogue.")
	Client.end_dialogue()
	next_flow()

func _get_current_line() -> Dialogue.Line:
	if current_line >= len(current_script.get_dialogue()): return 
	return current_script.get_dialogue().get(current_line) as Dialogue.Line

# ============INTERACT HANDLING=================
func start_interacting(interact_id: String) -> void:
	interact_manager.server_interact_start(interact_id)

func stop_interacting(interact_id: String) -> void:
	interact_manager.server_interact_stop(interact_id)
