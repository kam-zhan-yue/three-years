class_name Placement
extends Node3D

enum Type {
	Kitchen,
	Shelf,
	FutonWato,
	FutonAlex,
}

@export var type: Placement.Type

@onready var popup := %PlacementPopup as PlacementPopup
@onready var area := %Area3D as Area3D

var activated := false
var player: Player

signal completed(type: Placement.Type)

func _ready() -> void:
	popup.hide_popup()

func activate() -> void:
	Global.print("activating %s" % name)
	activated = true
	area.body_entered.connect(_body_entered)

func _body_entered(body: Node3D) -> void:
	if !activated: return
	if body == Client.game.player: 
		player = body as Player
		popup.show_popup()

func _body_exited(body: Node3D) -> void:
	if body == Client.game.player: 
		player = null
		popup.hide_popup()

func _input(event: InputEvent) -> void:
	var is_selected := event.is_action_pressed("interact")
	if is_selected && player && activated:
		player.global_position = global_position
		player.global_rotation = global_rotation
		player.deactivate()
		_complete()


func _complete() -> void:
	popup.hide_popup()
	activated = false
	completed.emit(type)
