class_name Interactor
extends Node3D

@onready var area := %InteractorArea as Area3D

var current: Interactable
var interacting := false

func _ready() -> void:
	if !is_multiplayer_authority():
		return
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body is not Interactable: return
	var interactable := body as Interactable
	current = interactable
	if interactable.can_interact():
		interactable.hover()

func _on_body_exited(body: Node3D) -> void:
	if body is Interactable:
		var interactable := body as Interactable
		if interactable == current:
			Server.stop_interacting(current.id())
			current = null

func _input(event: InputEvent) -> void:
	if current == null: return
	if event.is_action_pressed("interact") and current.can_interact():
		Server.start_interacting(current.id())
		interacting = true

	if event.is_action_released("interact") and current.interacting:
		Server.stop_interacting(current.id())
		interacting = false
