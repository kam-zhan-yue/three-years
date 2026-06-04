class_name GameServer
extends Node

var game := Game.new()

func add_player(id: int, character: Game.Character) -> void:
	game.players[id] = character
	send_update()
	# if len(game.players) == 2:
	# 	Client.start_game()

	if len(game.players) == 2:
		game.start()

func send_update() -> void:
	Client.update_game(game.get_state())

func continue_dialogue(line: Dialogue.Line) -> void:
	game.continue_dialogue(line)
