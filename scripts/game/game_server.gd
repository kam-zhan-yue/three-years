class_name GameServer
extends Node

var players: Dictionary[int, Game.Character] = {}

func add_player(id: int, character: Game.Character) -> void:
	players[id] = character
	if len(players) == 2:
		Client.start_game()
