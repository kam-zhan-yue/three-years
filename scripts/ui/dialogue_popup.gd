class_name DialoguePopup
extends Control

@onready var dialogue := %Dialogue as RichTextLabel
@onready var speaker := %Speaker as RichTextLabel

var current_line: Dialogue.Line
var showing := false

func _ready() -> void:
	Global.set_inactive(self)

	Client.dialogue_started.connect(_on_dialogue_started)
	Client.dialogue_continued.connect(_on_dialogue_continued)
	Client.dialogue_ended.connect(_on_dialogue_ended)

func show_popup() -> void:
	showing = true
	Global.set_active(self)

func hide_popup() -> void:
	showing = false
	Global.set_inactive(self)

func _input(event: InputEvent) -> void:
	if !showing: return
	var is_clicked := event.is_action_pressed("ui_accept")
	var is_same_character = current_line and current_line.speaker == Client.game.character
	if is_clicked and is_same_character:
		Server.continue_dialogue(current_line)

func _on_dialogue_started(line: Dialogue.Line) -> void:
	show_popup()
	set_line(line)

func _on_dialogue_continued(line: Dialogue.Line) -> void:
	set_line(line)

func set_line(line: Dialogue.Line) -> void:
	current_line = line
	speaker.text = Dialogue.SPEAKERS[line.speaker]
	dialogue.text = line.body

func _on_dialogue_ended() -> void:
	hide_popup()
