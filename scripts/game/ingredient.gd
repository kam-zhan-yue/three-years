class_name Ingredient
extends Node3D

@onready var model = $Model

var tween: Tween

func select() -> void:
	Services.shelf.client_select(get_type())

func highlight() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(model, "scale", Vector3(1.1, 1.1, 1.1), 0.15)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT_IN)

func unhighlight() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(model, "scale", Vector3(1, 1, 1), 0.15)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT_IN)

func get_type() -> String:
	return name

func consume() -> void:
	Global.set_inactive(self)
