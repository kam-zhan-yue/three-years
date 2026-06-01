class_name ConnectionPopup
extends Control

@onready var connect_button := %Connect as Button

func _ready() -> void:
	connect_button.button_down.connect(_on_connect_clicked)

func _on_connect_clicked() -> void:
	Global.set_inactive(self)
	Server.start_client()
