class_name GameEndPopup
extends Control

@onready var panel_container := %PanelContainer as PanelContainer
@onready var restart_button := %RestartButton as Button

var showing := true

func _ready() -> void:
	restart_button.button_down.connect(_restart_button_clicked)
	Global.set_inactive(self)

func show_popup() -> void:
	showing = true
	Global.set_active(self)

func hide_popup() -> void:
	showing = false
	Global.set_inactive(self)

func _restart_button_clicked() -> void:
	Global.print("Requested to restart game")
	Server.restart_game_request()
