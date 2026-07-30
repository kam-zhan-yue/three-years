extends Node

var peer: ENetMultiplayerPeer
var game: GameServer

enum State {
	Waiting,
}

# Only runs once
func start() -> void:
	multiplayer.peer_connected.connect(_on_connected)
	multiplayer.peer_disconnected.connect(_on_disconnect)
	peer = ENetMultiplayerPeer.new()
	peer.create_server(Global.PORT)
	multiplayer.multiplayer_peer = peer

	start_game()

func start_game() -> void:
	Services.players.server_reset_players()
	Global.print("Starting Server")
	if game:
		game.free()
	game = GameServer.new()
	game.start_game()

# When a peer connects, send them a game update to let them know how it is going
func _on_connected(_id: int) -> void:
	if !multiplayer.is_server(): return
	if !game: return
	game.send_update()

func _on_disconnect(id: int) -> void:
	if id in game.server_players:
		Global.print("Player %s disconnected, restart game!" % id)
		start_game()
		Client.restart_game()

# Broadcasts a message to all clients
func broadcast(message: String) -> void:
	_broadcast_message.rpc_id(1, message)

@rpc("any_peer", "call_remote", "reliable")
func _broadcast_message(message: String) -> void:
	if !multiplayer.is_server(): return
	Client.print(message)

# Selects a character
func select_character(character: Game.Character) -> void:
	_select_character.rpc_id(1, Global.id(), character)

@rpc("any_peer", "call_remote", "reliable")
func _select_character(id: int, character: Game.Character) -> void:
	if !multiplayer.is_server(): return
	game.add_player(id, character)

#==================Interactions====================
func start_interacting(interact_id: String) -> void:
	_start_interacting.rpc_id(1, interact_id)

@rpc("any_peer", "call_remote", "reliable")
func _start_interacting(interact_id: String) -> void:
	game.start_interacting(interact_id)

func stop_interacting(interact_id: String) -> void:
	_stop_interacting.rpc_id(1, interact_id)

@rpc("any_peer", "call_remote", "reliable")
func _stop_interacting(interact_id: String) -> void:
	game.stop_interacting(interact_id)

func complete_interact(interact_id: String) -> void:
	game.complete_interact(interact_id)

#==================Dialogue====================
func skip_dialogue_animation(line: Dialogue.Line) -> void:
	_skip_dialogue_animation.rpc_id(1, Global.id(), inst_to_dict(line))

@rpc("any_peer", "call_remote", "reliable")
func _skip_dialogue_animation(client_id: int, line_dict: Dictionary) -> void:
	if !multiplayer.is_server(): return
	Global.debug("SKipping dialogue animation...")
	
	# Validate that the player can request to continue this dialogue
	var line := dict_to_inst(line_dict) as Dialogue.Line
	if _can_change_dialogue(client_id, line):
		game.skip_dialogue_animation(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	_continue_dialogue.rpc_id(1, Global.id(), inst_to_dict(line))

@rpc("any_peer", "call_remote", "reliable")
func _continue_dialogue(client_id: int, line_dict: Dictionary) -> void:
	if !multiplayer.is_server(): return
	Global.debug("Progressing dialogue...")
	
	# Validate that the player can request to continue this dialogue
	var line := dict_to_inst(line_dict) as Dialogue.Line
	if _can_change_dialogue(client_id, line):
		game.continue_dialogue(line)

func _can_change_dialogue(client_id: int, line: Dialogue.Line) -> bool:
	var character := game.get_character(client_id)
	if line.speaker != Game.Character.None and character != line.speaker:
		return false
	return true

#==================Camera====================
func activate_camera_zones() -> void:
	Client.activate_camera_zones()

func switch_camera(character: Game.Character, camera: CameraManager.Camera) -> void:
	var id := game.get_player_id(character)
	Client.switch_camera.rpc_id(id, camera)

func activate_shelf(character: Game.Character) -> void:
	var id := game.get_player_id(character)
	Client.activate_shelf.rpc_id(id)

func deactivate_shelf(character: Game.Character) -> void:
	var id := game.get_player_id(character)
	Client.deactivate_shelf.rpc_id(id)

func select_ingredient(type: String) -> void:
	_select_ingredient.rpc_id(1, type)

@rpc("any_peer", "call_remote", "reliable")
func _select_ingredient(type: String) -> void:
	game.select_ingredient(type)

#==================Placement====================
func set_placement(character: Game.Character, placement: Placement.Type) -> void:
	var id := game.get_player_id(character)
	Client.set_placement.rpc_id(id, placement)

func confirm_placement(type: Placement.Type) -> void:
	_confirm_placement.rpc_id(1, type)

@rpc("any_peer", "call_remote", "reliable")
func _confirm_placement(type: Placement.Type) -> void:
	game.confirm_placement(type)

#==================Players====================
func set_player_active(character: Game.Character, active: bool) -> void:
	var id := game.get_player_id(character)
	Client.set_player_active.rpc_id(id, active)

func register_player(character: Game.Character) -> void:
	_register_player.rpc_id(1, character)

@rpc("any_peer", "call_remote", "reliable")
func _register_player(character: Game.Character) -> void:
	Services.players.server_register_player(character)
