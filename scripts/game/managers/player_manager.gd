class_name PlayerManager
extends Node3D

signal server_players_loaded
var server_players: Dictionary[int, Game.Character] = {}
var server_loaded_players := []

func server_init_player(id: int, character: Game.Character) -> void:
	server_players[id] = character

func server_register_player(character: Game.Character) -> void:
	Global.print("Character joined: %s" % character)
	server_loaded_players.append(character)
	if len(server_loaded_players) == 2:
		server_players_loaded.emit()

func server_activate_all(active: bool) -> void:
	Server.set_player_active(Game.Character.Wato, active)
	Server.set_player_active(Game.Character.Alex, active)

func server_activate(character: Game.Character, active: bool) -> void:
	Server.set_player_active(character, active)

func client_activate(active: bool) -> void:
	Global.print("Setting to %s" % active)
	if active:
		Client.game.player.activate()
	else:
		Client.game.player.deactivate()
