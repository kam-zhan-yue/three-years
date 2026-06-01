class_name Player
extends CharacterBody3D

@export var speed := 500.0

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(_delta: float) -> void:
	if !is_multiplayer_authority(): return
	var velocity_2d := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
	velocity = Vector3(velocity_2d.x, 0, velocity_2d.y)
	move_and_slide()
