class_name InteractManager
extends Node3D

# Hard Coded Interactable Objects
@onready var interactable_holder := %Interactables as Node3D

var interactables: Dictionary[String, Interactable]

signal on_completed

func _ready() -> void:
	for child in interactable_holder.get_children():
		if !child.visible: continue
		if child is Interactable:
			var interactable := child as Interactable
			interactables[interactable.id()] = interactable

func server_activate() -> void:
	for interactable in interactables.values():
		interactable.server_activate()

func server_interact_start(interact_id: String) -> void:
	if interact_id not in interactables: return
	var interactable = interactables[interact_id]
	interactable.server_interact()
	
func server_interact_stop(interact_id: String) -> void:
	if interact_id not in interactables: return
	var interactable = interactables[interact_id]
	interactable.server_stop()

func client_interact_complete(interact_id: String) -> void:
	if interact_id not in interactables: return
	var interactable = interactables[interact_id]
	interactable.client_completed()

func server_check_all_completed() -> void:
	# Check if all the interactables are completed
	for interactable in interactables.values():
		if !interactable.completed: return
	on_completed.emit()
