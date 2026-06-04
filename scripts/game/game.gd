class_name Game

# Struct-like data structure to represent the game
class GameState:
	var players: Dictionary[int, Game.Character]

enum Character {
	Alex,
	Wato,
}

enum State {
	INTRO,
	CLEAN_ROOM,
	COOK_LUNCH,
	EAT_LUNCH,
}

var players: Dictionary[int, Game.Character] = {}
var dialogue_script: DialogueScript
var current_line := 0

var DIALOGUES: Dictionary[Dialogue.Event, DialogueScript] = {
	Dialogue.Event.Clean: ScriptCleanRoom.new(),
	Dialogue.Event.Cook: ScriptCookLunch.new(),
	Dialogue.Event.Eat: ScriptEatLunch.new(),
}

func start() -> void:
	start_dialogue_event(Dialogue.Event.Clean)

func get_state() -> GameState:
	var state := GameState.new()
	state.players = players
	return state

func start_dialogue_event(event: Dialogue.Event) -> void:
	if event not in DIALOGUES: return
	dialogue_script = DIALOGUES[event]
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



# Private Functions
func _get_current_line() -> Dialogue.Line:
	if current_line >= len(dialogue_script.get_dialogue()): return 
	return dialogue_script.get_dialogue().get(current_line) as Dialogue.Line
