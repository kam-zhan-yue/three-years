class_name CharacterSelectionPopup
extends Control

@onready var selection_holder := %SelectionHolder as Control
@onready var connection_failed_holder := %ConnectionFailed as Control
@onready var connecting_holder := %Connecting as Control
@onready var alex_button := %Alex as Button
@onready var wato_button := %Wato as Button

func _ready() -> void:
	alex_button.button_down.connect(_on_alex_clicked)
	wato_button.button_down.connect(_on_wato_clicked)
	Client.game_updated.connect(_on_game_updated)

	Global.set_active(connecting_holder)
	Global.set_inactive(connection_failed_holder)
	Global.set_inactive(selection_holder)

func _on_game_updated(state: Game.GameState):
	Global.debug("Players: %s" % len(state.players))
	for character in state.players.values():
		if character == Game.Character.Alex:
			Global.set_inactive(alex_button)
		elif character == Game.Character.Wato:
			Global.set_inactive(wato_button)

func _on_alex_clicked() -> void:
	_on_select(Game.Character.Alex)

func _on_wato_clicked() -> void:
	_on_select(Game.Character.Wato)

func _on_select(character: Game.Character) -> void:
	Global.set_inactive(self)
	Global.print("Selecting?")
	Client.select_character(character)

func show_selection() -> void:
	Global.set_inactive(connecting_holder)
	Global.set_inactive(connection_failed_holder)
	Global.set_active(selection_holder)

func _on_connected_fail() -> void:
	Global.set_inactive(connecting_holder)
	Global.set_active(connection_failed_holder)
	Global.set_inactive(selection_holder)
