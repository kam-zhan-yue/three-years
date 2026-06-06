class_name Interactable
extends Node3D

@export var interacting := false
@export var initial_progress := 5.0
var progress := initial_progress

@onready var popup := %InteractablePopup as InteractablePopup

func _ready() -> void:
	popup.init(self)

func id() -> String:
	return str(get_path())

func interact() -> void:
	Global.print("Interacting")
	self.interacting = true

func stop() -> void:
	Global.print("Stopping")
	self.interacting = false

func _process(delta: float) -> void:
	if !multiplayer.is_server(): return
	if interacting:
		progress -= delta
