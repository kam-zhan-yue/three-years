class_name InteractManager
extends Node3D

# Hard Coded Interactable Objects
@onready var interactable_holder := %Interactables as Node3D

var interactables: Dictionary[String, Interactable]

func _ready() -> void:
	for child in interactable_holder.get_children():
		if child is Interactable:
			var interactable := child as Interactable
			interactables[interactable.id()] = interactable

func interact_start(interact_id: String) -> void:
	if interact_id not in interactables: return
	var interactable = interactables[interact_id]
	interactable.interact()
	
func interact_stop(interact_id: String) -> void:
	if interact_id not in interactables: return
	var interactable = interactables[interact_id]
	interactable.stop()
