class_name DialogueManager
extends Node3D

var game := Game.new()

# Server Side Stuffs
var current_script: DialogueScript
var current_line := 0

signal event_triggered(event: Dialogue.Event)
signal dialogue_ended()

func client_start(line: Dialogue.Line) -> void:
	Services.ui.dialogue_popup.start_dialogue(line)

func client_continue(line: Dialogue.Line) -> void:
	Services.ui.dialogue_popup.continue_dialogue(line)

func client_end() -> void:
	Services.ui.dialogue_popup.end_dialogue()

func server_start(dialogue: DialogueScript) -> void:
	current_script = dialogue
	current_line = 0
	var line := _get_current_line()
	if !line: return
	server_trigger_event(line)
	Client.start_dialogue(line)

func server_continue(line: Dialogue.Line) -> void:
	var current := _get_current_line()
	# If we are not at the current line, then don't progress
	if current.speaker != line.speaker or current.body != line.body: return

	# If the line needs a reponse, then don't progress
	if line.response != null: return

	current_line += 1
	var next_line := _get_current_line()
	if !next_line:
		server_end_dialogue()
	else:
		server_trigger_event(line)
		Client.continue_dialogue(next_line)

func server_trigger_event(line: Dialogue.Line) -> void:
	if line.event == Dialogue.Event.None: return
	event_triggered.emit(line.event)

func server_end_dialogue() -> void:
	Global.debug("Ending Dialogue.")
	Client.end_dialogue()
	dialogue_ended.emit()


func _get_current_line() -> Dialogue.Line:
	if current_line >= len(current_script.get_dialogue()): return 
	return current_script.get_dialogue().get(current_line) as Dialogue.Line
