class_name Game

# Struct-like data structure to represent the game
class GameState:
	var players: Dictionary[int, Game.Character]

enum Character {
	Alex,
	Wato,
}

enum EventType {
	Dialogue,
	Game
}

enum Event {
	Clean,
	Cook,
	Eat,
}

var players: Dictionary[int, Game.Character] = {}

var DIALOGUES: Dictionary[Dialogue.Event, DialogueScript] = {
	Dialogue.Event.Clean: DialogueCleanRoom.new(),
	Dialogue.Event.Cook: DialogueCookLunch.new(),
	Dialogue.Event.Eat: DialogueEatLunch.new(),
}

var current_script: DialogueScript
var current_line := 0

var EVENTS: Dictionary[Event, GameEvent] = {
	Event.Clean: GameEventClean.new(),
	Event.Cook: GameEventCook.new(),
	Event.Eat: GameEventEat.new(),
}

var current_event: GameEvent

var FLOW := [
	Global.dialogue_event(Dialogue.Event.Clean),
	Global.game_event(Event.Clean),
	Global.dialogue_event(Dialogue.Event.Cook),
	Global.game_event(Event.Cook),
	Global.dialogue_event(Dialogue.Event.Eat),
	Global.game_event(Event.Eat),
]

var flow := 0

func start() -> void:
	enter_flow(0)

func get_state() -> GameState:
	var state := GameState.new()
	state.players = players
	return state

# ============FLOW HANDLING=================
func enter_flow(index: int) -> void:
	flow = index
	if flow >= len(FLOW):
		return # end flow here
	var event_type := Global.get_event_type(FLOW[index])
	var event := Global.get_event(FLOW[index])
	Global.print("Entering %s" % FLOW[index])
	if event_type == EventType.Dialogue:
		start_dialogue_event(event)
	elif event_type == EventType.Game:
		start_game_event(event)

func next_flow() -> void:
	enter_flow(flow + 1)

# ============EVENT HANDLING=================
func start_game_event(event: Game.Event) -> void:
	if event not in EVENTS: return
	current_event = EVENTS[event]
	start_event()

func start_event() -> void:
	pass

# ============DIALOGUE HANDLING=================
func start_dialogue_event(event: Dialogue.Event) -> void:
	if event not in DIALOGUES: return
	current_script = DIALOGUES[event]
	start_dialogue()

func start_dialogue() -> void:
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



# Private Functions
func _get_current_line() -> Dialogue.Line:
	if current_line >= len(current_script.get_dialogue()): return 
	return current_script.get_dialogue().get(current_line) as Dialogue.Line
