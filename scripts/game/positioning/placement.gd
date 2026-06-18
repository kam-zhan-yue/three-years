class_name Placement
extends Node3D

enum Type {
	Kitchen,
	Shelf,
}

@export var type: Placement.Type

@onready var popup := %PlacementPopup as PlacementPopup
@onready var area := %Area3D as Area3D

var activated := false

signal completed

func _ready() -> void:
	popup.hide_popup()

func activate() -> void:
	activated = true
	area.body_entered.connect(_body_entered)

func _body_entered(body: Node3D) -> void:
	if !activated: return
	if body == Client.game.player: 
		Global.print("Oh yeah!")
		popup.show_popup()
		pass

func _body_exited(body: Node3D) -> void:
	if body == Client.game.player: 
		popup.hide_popup()


func _complete() -> void:
	activated = false
	completed.emit()
