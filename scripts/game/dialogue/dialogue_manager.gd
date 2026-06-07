class_name DialogueManager
extends Node3D

var game := Game.new()

var current_event: Dialogue.Event
var current_script: DialogueScript
var current_line := 0

signal dialogue_ended(event: Dialogue.Event)

# ============DIALOGUE HANDLING=================
func server_start(event: Dialogue.Event) -> void:
	if event not in game.DIALOGUES: return
	current_event = event
	current_script = game.DIALOGUES[event]
	current_line = 0
	var line := _get_current_line()
	if !line: return
	Client.start_dialogue(line)

func server_continue(line: Dialogue.Line) -> void:
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
	dialogue_ended.emit(current_event)
	# next_flow()

func _get_current_line() -> Dialogue.Line:
	if current_line >= len(current_script.get_dialogue()): return 
	return current_script.get_dialogue().get(current_line) as Dialogue.Line
