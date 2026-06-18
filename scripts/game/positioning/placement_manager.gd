class_name PlacementManager
extends Node3D

@onready var placements_node := %Placements as Node3D

var placements: Dictionary[Placement.Type, Placement] = {}
var current: Placement

signal server_placement_completed(type: Placement.Type)

func _ready() -> void:
	for child in placements_node.get_children():
		if child is not Placement: continue
		var placement := child as Placement
		placements[placement.type] = placement

func server_set(character: Game.Character, placement: Placement.Type) -> void:
	Server.set_placement(character, placement)

func client_set(placement: Placement.Type) -> void:
	if placement not in placements:
		Global.error("Placement %s was not found" % placement)
		return

	current = placements[placement]
	current.completed.connect(_completed)
	current.activate()

func _completed(type: Placement.Type) -> void:
	current.completed.disconnect(_completed)
	current = null
	client_confirm(type)

func client_confirm(type: Placement.Type) -> void:
	Server.confirm_placement(type)

func server_confirm(type: Placement.Type) -> void:
	server_placement_completed.emit(type)
