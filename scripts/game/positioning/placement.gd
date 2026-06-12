class_name Placement
extends Node3D

enum Type {
	Kitchen,
	Shelf,
}

@export var type: Placement.Type

signal completed

func activate() -> void:
	pass

func _complete() -> void:
	completed.emit()
