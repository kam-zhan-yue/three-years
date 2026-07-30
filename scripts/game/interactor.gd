class_name Interactor
extends Node3D

@onready var area := %InteractorArea as Area3D

var interacting := false
var interactables: Array[Interactable] = []

func _ready() -> void:
	if !is_multiplayer_authority():
		return
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)

func _on_area_entered(body: Node3D) -> void:
	if body is not Interactable: return
	var interactable := body as Interactable
	interactables.append(interactable)
	if interactable.can_interact():
		interactable.hover_start()

func _on_area_exited(body: Node3D) -> void:
	if body is Interactable:
		var interactable := body as Interactable
		interactable.hover_stop()
		_remove_interactable(interactable)

func _remove_interactable(interactable: Interactable) -> void:
	for i in range(len(interactables)):
		if interactables[i] == interactable:
			interactables.remove_at(i)
			return


func _get_valid_interactables() -> Array[Interactable]:
	var valid: Array[Interactable] = []
	for interactable in interactables:
		if interactable.completed: continue
		valid.append(interactable)
	return valid

func _get_closest() -> Interactable:
	var valid = _get_valid_interactables()
	if len(valid) == 0: return null
	var min_distance := global_position.distance_to(valid[0].global_position)
	var min_index := 0

	for i in range(1, len(valid)):
		if valid[i].completed: continue
		var distance := global_position.distance_to(valid[0].global_position)
		if distance < min_distance:
			min_distance = distance
			min_index = i

	return valid[min_index]


func _input(event: InputEvent) -> void:
	var current = _get_closest()
	if current == null:
		interacting = false
		return

	if event.is_action_pressed("interact") and current.can_interact():
		Server.start_interacting(current.id())
		interacting = true

	if event.is_action_released("interact") and current.interacting:
		Server.stop_interacting(current.id())
		interacting = false
