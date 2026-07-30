class_name Interactable
extends Node3D

@onready var popup := %InteractablePopup as InteractablePopup
@onready var active_model := $ActiveModel as Node3D
@onready var inactive_model := $InactiveModel as Node3D

@export var activated := false
@export var initial_progress: float = 2.0
@export var interacting := false
@export var progress: float = initial_progress
@export var completed := false

func _ready() -> void:
	Global.set_active(active_model)
	Global.set_inactive(inactive_model)
	popup.init(self)

func server_activate() -> void:
	activated = true

func id() -> String:
	return str(get_path())

func hover_start() -> void:
	popup.hover_start()

func hover_stop() -> void:
	popup.hover_stop()

func can_interact() -> bool:
	return activated && !completed && !interacting && !Services.dialogue.client_is_playing

func server_interact() -> void:
	if !multiplayer.is_server(): return
	self.interacting = true

func server_stop() -> void:
	if !multiplayer.is_server(): return
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
	Server.complete_interact(id())

func client_completed() -> void:
	# Do effects here!
	if multiplayer.is_server(): return
	completed = true
	Global.set_active(inactive_model)
	Global.set_inactive(active_model)

func get_progress_value() -> float:
	return (initial_progress - progress) / initial_progress
