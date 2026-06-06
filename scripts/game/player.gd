class_name Player
extends CharacterBody3D

@onready var interactor := %Interactor as Interactor

@export var speed := 5.0

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

var activated := false

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

# func _ready() -> void:
# 	interactor.set_multiplayer_authority(name.to_int())

func activate() -> void:
	activated = true

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	if !activated: return

	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	var velocity_2d := Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	velocity = Vector3(velocity_2d.x, velocity.y, velocity_2d.y)
	move_and_slide()
