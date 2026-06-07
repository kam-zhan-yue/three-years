class_name GameClient
extends Node

var character: Game.Character
var player: Player
var player_activated: bool
var interact_manager: InteractManager
var dialogue_manager: DialogueManager

func _init(im: InteractManager, dm: DialogueManager) -> void:
	interact_manager = im
	dialogue_manager = dm

func set_character(c: Game.Character) -> void:
	character = c

func set_player(p: Player) -> void:
	player = p
	_activate_player()

func start_event(_event: Game.Event) -> void:
	_activate_player()

func _activate_player() -> void:
	player_activated = true
	if player:
		player.activate()

func complete_interaction(interact_id: String) -> void:
	interact_manager.client_interact_complete(interact_id)

func start_dialogue(line: Dialogue.Line) -> void:
	dialogue_manager.client_start(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	dialogue_manager.client_continue(line)

func end_dialogue() -> void:
	dialogue_manager.client_end()
