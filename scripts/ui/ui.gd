class_name UI
extends Control

@onready var dialogue_popup := %DialoguePopup as DialoguePopup
@onready var game_end_popup := %GameEndPopup as GameEndPopup

func server_show_game_end() -> void:
	Client.show_game_end_popup()

func client_show_game_end() -> void:
	game_end_popup.show_popup()
