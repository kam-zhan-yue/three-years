class_name GameServer
extends Node

var game_state := GameState.new()

func add_player(id: int, character: Game.Character) -> void:
	game_state.players[id] = character
	send_update()
	if len(game_state.players) == 2:
		Client.start_game()

func send_update() -> void:
	Client.update_game(game_state)
