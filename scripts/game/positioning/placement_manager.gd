class_name PlacementManager
extends Node3D

var placements: Dictionary[Placement.Type, Placement] = {}
var current: Placement

signal server_placement_completed

func _ready() -> void:
	for child in get_children():
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

func _completed() -> void:
	current.completed.disconnect(_completed)
	current = null
	client_confirm()

func client_confirm() -> void:
	Server.confirm_placement()

func server_confirm() -> void:
	server_placement_completed.emit()
