class_name GameClient
extends Node

var player: Player

func start_game() -> void:
	Global.print("Starting game!")
	player.activate()

func add_player(p: Player) -> void:
	player = p
