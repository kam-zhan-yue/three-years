class_name Ingredient
extends StaticBody3D

@onready var model = $Model

func select() -> void:
	Services.shelf.client_select(get_type())

func highlight() -> void:
	model.material.next_pass.set_shader_parameter("active", true)

func unhighlight() -> void:
	model.material.next_pass.set_shader_parameter("active", false)

func get_type() -> String:
	return name

func consume() -> void:
	Global.set_inactive(self)
