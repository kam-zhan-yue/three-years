class_name GameServer
extends Node

var players: Dictionary[int, String] = {}

func register_player(id: int, player: String) -> void:
	players[id] = player
	if len(players) == 2:
		Client.start_game()
