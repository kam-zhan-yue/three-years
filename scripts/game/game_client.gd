class_name GameClient
extends Node

var character: Game.Character
var player: Player
var started: bool

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
