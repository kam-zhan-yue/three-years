class_name CharacterSelectionPopup
extends Control

@onready var alex_button := %Alex as Button
@onready var wato_button := %Wato as Button

func _ready() -> void:
	alex_button.button_down.connect(_on_alex_clicked)
	wato_button.button_down.connect(_on_wato_clicked)


func _on_alex_clicked() -> void:
	_on_select(Game.Character.Alex)

func _on_wato_clicked() -> void:
	_on_select(Game.Character.Wato)

func _on_select(character: Game.Character) -> void:
	Global.set_inactive(self)
	Client.select_character(character)
