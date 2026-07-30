class_name DialoguePopup
extends Control

@export var text_speed := 10
@onready var dialogue := %Dialogue as RichTextLabel
@onready var speaker := %Speaker as RichTextLabel
@onready var alex_view := %AlexView as SubViewportContainer
@onready var wato_view := %WatoView as SubViewportContainer
@onready var alex_animator := %alex/AnimationPlayer as AnimationPlayer
@onready var wato_animator := %wato/AnimationPlayer as AnimationPlayer

var current_line: Dialogue.Line
var showing := false
var animating := false
var _timer := 0.0

func _ready() -> void:
	alex_animator.play("idle")
	wato_animator.play("idle")
	Global.set_inactive(self)

func show_popup() -> void:
	showing = true
	Global.set_active(self)

func hide_popup() -> void:
	showing = false
	Global.set_inactive(self)

func _get_text_interval() -> float:
	if text_speed <= 0: return 0
	return 1.0 / text_speed

func _process(delta: float) -> void:
	if !_can_animate():
		return

	_timer += delta
	if _timer >= _get_text_interval():
		_timer = 0.0
		_increment_dialogue_animation()
	pass

func _input(event: InputEvent) -> void:
	if !showing: return
	if current_line.response != null: return
	var is_clicked := event.is_action_pressed("select")
	var is_same_character = current_line and current_line.speaker == Client.game.character
	if is_clicked and is_same_character or current_line.speaker == Game.Character.None:
		_on_click()

func _on_click() -> void:
	if animating:
		animating = false
		Server.skip_dialogue_animation(current_line)
	else:
		Server.continue_dialogue(current_line)

func skip_animation(line: Dialogue.Line) -> void:
	if not Services.dialogue.is_equal(line, current_line):
		Global.error("Can't skip dialogue as lines are not equal. Server Line: %s, Client Line %s" % [line.body, current_line.body])
		return
	animating = false
	dialogue.visible_characters = len(current_line.body)

func start_dialogue(line: Dialogue.Line) -> void:
	show_popup()
	set_line(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	set_line(line)

func _can_animate() -> bool:
	return animating and dialogue.visible_characters < len(current_line.body)

func _increment_dialogue_animation() -> void:
	dialogue.visible_characters += 1
	if dialogue.visible_characters >= len(current_line.body):
		animating = false

func set_line(line: Dialogue.Line) -> void:
	animating = true
	current_line = line
	speaker.text = Dialogue.SPEAKERS[line.speaker]

	dialogue.text = ""
	dialogue.append_text("[dialogue]")
	dialogue.append_text(line.body)
	dialogue.append_text("[/dialogue]")

	dialogue.visible_characters = 1
	Global._active(alex_view, line.speaker == Game.Character.Alex)
	Global._active(wato_view, line.speaker == Game.Character.Wato)

func end_dialogue() -> void:
	hide_popup()
