class_name DialogueManager
extends Node3D

var game := Game.new()

# Server Side Stuffs
var current_script: DialogueScript
var current_line := 0
var client_is_playing := false
var server_is_playing = false

signal event_triggered(event: Dialogue.Event)
signal dialogue_ended()

func client_start(line: Dialogue.Line) -> void:
	client_is_playing = true
	Services.ui.dialogue_popup.start_dialogue(line)

func client_skip_animation(line: Dialogue.Line) -> void:
	Services.ui.dialogue_popup.skip_animation(line)

func client_continue(line: Dialogue.Line) -> void:
	Services.ui.dialogue_popup.continue_dialogue(line)

func client_end() -> void:
	client_is_playing = false
	Services.ui.dialogue_popup.end_dialogue()

func server_start(dialogue: DialogueScript) -> void:
	server_is_playing = true
	current_script = dialogue
	current_line = 0
	var line := _get_current_line()
	if !line: return
	server_trigger_event(line)
	Client.start_dialogue(line)


func is_equal(a: Dialogue.Line, b: Dialogue.Line) -> bool:
	if a.speaker != b.speaker or a.body != b.body: 
		return false
	return true


func server_skip_dialogue_animation(line: Dialogue.Line) -> void:
	# Check if we are on the current line and can skip the animation
	var current := _get_current_line()
	if not is_equal(_get_current_line(), line):
		Global.error("Line expecting %s, got %s" % [Global.SPEAKERS[current.speaker], Global.SPEAKERS[line.speaker]])
		return

	# Sync up the clients' dialogue
	Client.skip_dialogue_animation(line)

func server_continue(line: Dialogue.Line) -> void:
	var current := _get_current_line()
	if not is_equal(_get_current_line(), line):
		Global.error("Line expecting %s, got %s" % [Global.SPEAKERS[current.speaker], Global.SPEAKERS[line.speaker]])
		return
	if line.response != null: 
		Global.error("Line Expecting a response")
		return

	_continue()

func server_respond(character: Game.Character, respond_id: String) -> void:
	var current := _get_current_line()
	if current.response == null:
		Global.error("Attempting to respond to a line with no response")
		return
	if current.response.from != character: 
		Global.error("Response expecting %s, got %s" % [Global.SPEAKERS[current.response.from], Global.SPEAKERS[character]])
		return
	if respond_id not in current.response.ids:
		Global.error("%s not in response ids: %s" % [respond_id, current.response.ids])
		return
	_continue()

func _continue() -> void:
	current_line += 1
	var next_line := _get_current_line()
	if !next_line:
		server_end_dialogue()
	else:
		server_trigger_event(next_line)
		Client.continue_dialogue(next_line)

func server_trigger_event(line: Dialogue.Line) -> void:
	if line.event == Dialogue.Event.None: return
	event_triggered.emit(line.event)

func server_end_dialogue() -> void:
	server_is_playing = false
	Global.debug("Ending Dialogue.")
	Client.end_dialogue()
	dialogue_ended.emit()


func _get_current_line() -> Dialogue.Line:
	if current_line >= len(current_script.get_dialogue()): return 
	return current_script.get_dialogue().get(current_line) as Dialogue.Line
