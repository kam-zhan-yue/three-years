class_name GameClient
extends Node

var character: Game.Character
var player: Player
var started: bool
var interact_manager: InteractManager

func _init(im: InteractManager) -> void:
	interact_manager = im

func start_game() -> void:
	Global.print("Starting game!")
	started = true
	if player:
		player.activate()

func set_character(c: Game.Character) -> void:
	character = c

func set_player(p: Player) -> void:
	player = p
	if started:
		player.activate()

func start_event(_event: Game.Event) -> void:
	player.activate()


func complete_interaction(interact_id: String) -> void:
	interact_manager.client_interact_complete(interact_id)
