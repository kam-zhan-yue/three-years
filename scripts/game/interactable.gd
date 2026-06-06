class_name Interactable
extends Node3D

@onready var popup := %InteractablePopup as InteractablePopup
@onready var model := %Model as CSGBox3D

@export var initial_progress := 2.0
@export var interacting := false
@export var progress := initial_progress
@export var completed := false

func _ready() -> void:
	popup.init(self)

func id() -> String:
	return str(get_path())

func hover() -> void:
	# Show the E popup here
	pass

func can_interact() -> bool:
	return !completed && !interacting

func server_interact() -> void:
	if !multiplayer.is_server(): return
	Global.print("Interacting")
	self.interacting = true

func server_stop() -> void:
	if !multiplayer.is_server(): return
	Global.print("Stopping")
	self.interacting = false

func _process(delta: float) -> void:
	if !multiplayer.is_server(): return
	if completed: return
	if interacting:
		progress -= delta
		if progress <= 0:
			server_completed()

func server_completed() -> void:
	if !multiplayer.is_server(): return
	completed = true
	Client.complete_interaction(id())

func client_completed() -> void:
	# Do effects here!
	if multiplayer.is_server(): return
	model.material.set_shader_parameter("completed", true)
