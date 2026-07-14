class_name GameClient
extends Node

var character: Game.Character
var player: Player
var player_activated: bool

func set_character(c: Game.Character) -> void:
	character = c

func set_player(p: Player) -> void:
	player = p
	_activate_player()

func start_event(_event: Game.Event) -> void:
	# TODO: Fix this
	_activate_player()

func _activate_player() -> void:
	player_activated = true
	if player:
		player.activate()

func complete_interaction(interact_id: String) -> void:
	Services.interact.client_interact_complete(interact_id)

func start_dialogue(line: Dialogue.Line) -> void:
	Services.dialogue.client_start(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	Services.dialogue.client_continue(line)

func end_dialogue() -> void:
	Services.dialogue.client_end()
