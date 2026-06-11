class_name CameraZone
extends Node3D

@onready var area := $Area as Area3D
@onready var camera := $Camera as Camera3D

signal player_entered(Camera3D)

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body is not Player: return
	var player := body as Player
	if !player.is_multiplayer_authority(): return
	player_entered.emit(camera)
