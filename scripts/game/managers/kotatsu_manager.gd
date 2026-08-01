class_name KotatsuManager
extends Node3D

@export var pasta: Node3D
@export var pasta_gone: Node3D

func _ready() -> void:
	Global.set_inactive(pasta)
	Global.set_inactive(pasta_gone)

func server_show_pasta() -> void:
	Client.kotatsu_show_pasta()

func client_show_pasta() -> void:
	Global.set_active(pasta)
	Global.set_inactive(pasta_gone)

func server_hide_pasta() -> void:
	Client.kotatsu_hide_pasta()

func client_hide_pasta() -> void:
	Global.set_inactive(pasta)
	Global.set_active(pasta_gone)

func server_end_screen() -> void:
	Client.show_game_end_popup()
