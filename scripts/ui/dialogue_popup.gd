class_name DialoguePopup
extends Control

@onready var dialogue := %Dialogue as RichTextLabel
@onready var speaker := %Speaker as RichTextLabel

var current_line: Dialogue.Line
var showing := false

func _ready() -> void:
	Global.set_inactive(self)

func show_popup() -> void:
	showing = true
	Global.set_active(self)

func hide_popup() -> void:
	showing = false
	Global.set_inactive(self)

func _input(event: InputEvent) -> void:
	if !showing: return
	if current_line.response != null: return
	var is_clicked := event.is_action_pressed("select")
	var is_same_character = current_line and current_line.speaker == Client.game.character
	if is_clicked and is_same_character:
		Server.continue_dialogue(current_line)

func start_dialogue(line: Dialogue.Line) -> void:
	show_popup()
	set_line(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	set_line(line)

func set_line(line: Dialogue.Line) -> void:
	current_line = line
	speaker.text = Dialogue.SPEAKERS[line.speaker]
	dialogue.text = line.body

func end_dialogue() -> void:
	hide_popup()
