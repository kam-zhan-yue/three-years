class_name CameraZone
extends Camera3D

@onready var area := $Area as Area3D

signal player_entered

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body is not Player: return
	var player := body as Player
	if !player.is_multiplayer_authority(): return
	player_entered.emit()
