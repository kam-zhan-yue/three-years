class_name Interactor
extends Node3D

@onready var area := %InteractorArea as Area3D

var current: Interactable

func _ready() -> void:
	if !is_multiplayer_authority():
		return
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body is not Interactable: return

	var interactable := body as Interactable
	current = interactable

	if interactable.interacting: return
	Global.print("Show Interactable UI")

func _on_body_exited(body: Node3D) -> void:
	if body is Interactable:
		var interactable := body as Interactable
		if interactable == current:
			current = null

# func _process(delta: float) -> void:
# 	if current == null: return
# 	current.progress += delta
# 	Global.print("what the %s" % current.progress)

func _input(event: InputEvent) -> void:
	if current == null: return
	if event.is_action_pressed("interact"):
		if !current.interacting:
			Server.start_interacting(current.id())
		else:
			Global.print("Cannot interact with %s as it is busy" % current.name)

	if event.is_action_released("interact"):
		if current.interacting:
			Server.stop_interacting(current.id())
		else:
			Global.print("Cannot stop with %s as it hasn't started" % current.name)
