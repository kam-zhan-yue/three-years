class_name CameraManager
extends Node3D

@onready var shelf_camera := %ShelfCamera as Camera3D
@onready var main_zone := %MainZone as CameraZone
@onready var kitchen_zone := %KitchenZone as CameraZone
@onready var cameras := %Cameras as Node3D
@onready var dining_zone := %DiningZone as CameraZone

@onready var kotatsu_camera := %KotatsuCamera as Camera3D
@onready var kotatsu_alex_camera := %KotatsuAlex as Camera3D
@onready var kotatsu_wato_camera := %KotatsuWato as Camera3D
@onready var kotatsu_pasta_camera := %KotatsuPasta as Camera3D

enum Camera {
	None,
	Main,
	Shelf,
	Kitchen,
	Dining,
	Zone,
	Kotatsu,
	PastaZoom,
	KotatsuAlex,
	KotatsuWato,
}

var CAMERAS: Dictionary[Camera, Camera3D] = {}

var zones_activated := false
var current: Camera3D
var current_zone_camera: Camera3D

func _ready() -> void:
	CAMERAS[Camera.Main] = main_zone.camera
	CAMERAS[Camera.Shelf] = shelf_camera
	CAMERAS[Camera.Kitchen] = kitchen_zone.camera
	CAMERAS[Camera.Dining] = dining_zone.camera
	CAMERAS[Camera.Kotatsu] = kotatsu_camera
	CAMERAS[Camera.KotatsuAlex] = kotatsu_alex_camera
	CAMERAS[Camera.KotatsuWato] = kotatsu_wato_camera
	CAMERAS[Camera.PastaZoom] = kotatsu_pasta_camera
	client_switch_camera(Camera.Dining)
	for child in cameras.get_children():
		if child is CameraZone:
			var zone := child as CameraZone
			zone.player_entered.connect(_zone_entered)

func _zone_entered(camera: Camera3D):
	if not zones_activated: return
	current = camera
	current_zone_camera = camera
	camera.make_current()


func server_activate_zones() -> void:
	Server.activate_camera_zones()

func client_activate_zones() -> void:
	Global.print("CAMERA | Activating zones")
	zones_activated = true
	pass

func server_switch_camera_all(camera: Camera) -> void:
	Client.switch_camera_all(camera)

func server_switch_camera(character: Game.Character, camera: Camera) -> void:
	Server.switch_camera(character, camera)

func client_switch_camera(next: Camera) -> void:
	if next == Camera.Zone and current_zone_camera:
		current = current_zone_camera
		if current == null:
			Global.error("Camera | Zone Camera is null %s")
			return

		current.make_current()
	elif next in CAMERAS:
		current = CAMERAS[next]
		if current == null:
			Global.error("Camera | Target camera %s is null" % Camera.keys()[next])
			return
		CAMERAS[next].make_current()
	else:
		Global.error("Camera | Trying to switch to %s" % next)
