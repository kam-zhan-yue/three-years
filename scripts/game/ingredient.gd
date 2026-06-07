class_name Ingredient
extends StaticBody3D

@onready var model = $Model

signal selected(type: String)

func select() -> void:
	selected.emit(name) # Fuck it, we ball

func highlight() -> void:
	model.material.next_pass.set_shader_parameter("active", true)

func unhighlight() -> void:
	model.material.next_pass.set_shader_parameter("active", false)
