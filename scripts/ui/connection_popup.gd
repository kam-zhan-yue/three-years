class_name ConnectionPopup
extends Control

@onready var server_button := %Server as Button
@onready var client_button := %Client as Button

func _ready() -> void:
	server_button.button_down.connect(_on_server_clicked)
	client_button.button_down.connect(_on_client_clicked)

func _on_server_clicked() -> void:
	Server.start_server()

func _on_client_clicked() -> void:
	Server.start_client()
