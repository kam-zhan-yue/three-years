class_name GameManager
extends Node

var counter := 0.0
var timer := 0

@onready var interact_manager = %InteractManager as InteractManager
@onready var dialogue_manager = %DialogueManager as DialogueManager
@onready var camera_manager = %CameraManager as CameraManager
@onready var shelf_manager = %ShelfManager as ShelfManager
@onready var placement_manager = %PlacementManager as PlacementManager
@onready var player_manager = %PlayerManager as PlayerManager
@onready var kotatsu_manager = %KotatsuManager as KotatsuManager
@onready var ui = %UI as UI

func _ready() -> void:
	Services.ui = ui
	Services.interact = interact_manager
	Services.dialogue = dialogue_manager
	Services.camera = camera_manager
	Services.shelf = shelf_manager
	Services.placement = placement_manager
	Services.players = player_manager
	Services.kotatsu = kotatsu_manager
