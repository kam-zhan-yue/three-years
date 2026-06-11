class_name CameraManager
extends Node3D

@onready var shelf_camera := %ShelfCamera as Camera3D
@onready var main_zone := %MainZone as CameraZone
@onready var cameras := %Cameras as Node3D

enum Camera {
	Main,
	Shelf,
	Zone,
}

var CAMERAS: Dictionary[Camera, Camera3D] = {}

var current: Camera3D

func _ready() -> void:
	CAMERAS[Camera.Main] = main_zone.camera
	CAMERAS[Camera.Shelf] = shelf_camera
	client_switch_camera(Camera.Main)
	for child in cameras.get_children():
		if child is CameraZone:
			var zone := child as CameraZone
			zone.player_entered.connect(_zone_entered)

func _zone_entered(camera: Camera3D):
	current = camera
	camera.make_current()


func server_switch_camera(character: Game.Character, camera: Camera) -> void:
	Server.switch_camera(character, camera)

func client_switch_camera(next: Camera) -> void:
	if next not in CAMERAS: return
	current = CAMERAS[next]
	CAMERAS[next].make_current()
