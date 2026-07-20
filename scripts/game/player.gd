class_name Player
extends CharacterBody3D

@onready var interactor := %Interactor as Interactor

@export var rotation_offset := PI * 0.5
@export var rotation_speed := TAU * 3 # 2 full rotations per second
@export var speed := 5.0

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

var activated := false

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func activate() -> void:
	activated = true

func deactivate() -> void:
	activated = false

func _can_move() -> bool:
	return activated && !interactor.interacting

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	if not _can_move(): 
		move_and_slide()
		return

	var cam_basis = Services.camera.current.global_transform.basis

	# Kill the vertical Y axis to keep movement flat on the ground plane
	var forward := Vector3(cam_basis.z.x, 0.0, cam_basis.z.z).normalized()
	var right := Vector3(cam_basis.x.x, 0.0, cam_basis.x.z).normalized()
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (forward * input_dir.y + right * input_dir.x).normalized()
	var direction_2d := Vector2(direction.x, direction.z)

	if direction_2d:
		rotation.y = rotate_toward(
			rotation.y,
			Vector2(direction_2d.x, -direction_2d.y).angle() + rotation_offset,
			rotation_speed * delta
		)
	
	var velocity_2d := direction_2d * speed
	velocity = Vector3(velocity_2d.x, velocity.y, velocity_2d.y)
	move_and_slide()

func _interact_started() -> void:
	self.activated = false

func _interact_stopped() -> void:
	self.activated = true
