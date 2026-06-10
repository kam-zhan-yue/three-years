class_name CameraManager
extends Node3D

@onready var shelf_camera := %ShelfCamera as Camera3D
@onready var main_zone := %MainZone as CameraZone

enum Camera {
	Main,
	Shelf,
}

var CAMERAS: Dictionary[Camera, Camera3D] = {}

var current := Camera.Main

func _ready() -> void:
	CAMERAS[Camera.Main] = main_zone
	CAMERAS[Camera.Shelf] = shelf_camera
	client_switch_camera(Camera.Main)

func server_switch_camera(character: Game.Character, camera: Camera) -> void:
	Server.switch_camera(character, camera)

func client_switch_camera(next: Camera) -> void:
	if next not in CAMERAS: return
	current = next
	CAMERAS[next].make_current()
