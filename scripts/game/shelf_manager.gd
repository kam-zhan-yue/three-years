class_name ShelfManager
extends Node3D

@onready var ingredient_holder := %Ingredients as Node3D
@onready var fridge_model := %FridgeModel as Node3D
@onready var fridge_animator := %FridgeModel/AnimationPlayer as AnimationPlayer

var ingredients: Array[Ingredient] = []

var activated := false
var current: Ingredient

signal server_ingredient_selected(type: String)

func _ready() -> void:
	for child in ingredient_holder.get_children():
		if child is Ingredient:
			var ingredient := child as Ingredient
			ingredients.append(ingredient)

func server_activate(character: Game.Character) -> void:
	Server.activate_shelf(character)

func server_deactivate(character: Game.Character) -> void:
	Server.deactivate_shelf(character)

func client_activate() -> void:
	fridge_animator.play("door-open")
	activated = true

func client_deactivate() -> void:
	fridge_animator.play("door-close")
	activated = false

func _input(event: InputEvent) -> void:
	if !activated: return
	if event is InputEventMouseMotion:
		var mouse_pos := (event as InputEventMouseMotion).position
		var ingredient = _ingredient_under_mouse(mouse_pos)
		if ingredient:
			if current != ingredient:
				ingredient.highlight()
			if current and current != ingredient:
				current.unhighlight()
			current = ingredient
		else:
			if current:
				current.unhighlight()
			current = null
	if event.is_action_pressed("select") and current:
		current.select()

func _ingredient_under_mouse(mouse: Vector2) -> Ingredient:
	var camera := Services.camera.shelf_camera
	var world_space := camera.get_world_3d().direct_space_state
	var start := camera.project_position(mouse, 0)
	var end := camera.project_position(mouse, 1000)
	var params := PhysicsRayQueryParameters3D.create(start, end)
	var result: Dictionary = world_space.intersect_ray(params)
	if "collider" not in result: 
		return null
	
	var collider := result["collider"] as PhysicsBody3D
	if not collider:
		return null

	var collider_parent := collider.get_parent()
	if collider_parent and collider_parent is Ingredient:
		return collider_parent as Ingredient
	return null

func client_select(type: String) -> void:
	Server.select_ingredient(type)

func server_select(type: String) -> void:
	server_ingredient_selected.emit(type)

func server_consume(type: String) -> void:
	Server.consume_ingredient(type)

func client_consume(type: String) -> void:
	for ingredient in ingredients:
		if ingredient.get_type() == type:
			ingredient.consume()
			return
