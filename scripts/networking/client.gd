extends Node

var peer: ENetMultiplayerPeer
var game: GameClient

signal game_updated(state: Game.GameState)

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	if OS.has_feature("localhost"):
		peer.create_client(Global.LOCALHOST, Global.PORT)
	else:
		peer.create_client(Global.IP_ADDRESS, Global.PORT)
	multiplayer.multiplayer_peer = peer
	start_game()

func start_game() -> void:
	Global.print("Starting Client")
	if game:
		game.free()
	game = GameClient.new()

func restart_game() -> void:
	_restart_game.rpc()

@rpc("authority", "call_remote", "reliable")
func _restart_game() -> void:
	Global.print("Restarting Client-Side Game")
	get_tree().reload_current_scene()

#==================Debugging====================
func print(message: String) -> void:
	_print_message.rpc(message)

@rpc("authority", "call_remote", "reliable")
func _print_message(text: String) -> void:
	Global.print(text)

#==================Game Events====================
func start_game_event(event: Game.Event) -> void:
	_start_game_event.rpc(event)

@rpc("authority", "call_remote", "reliable")
func _start_game_event(event: Game.Event) -> void:
	Global.debug("Starting Game Event: %s" % Global.EVENT_NAME[event])
	# game.start_event(event)

#==================Dialogue====================
func start_dialogue(line: Dialogue.Line) -> void:
	_start_dialogue.rpc(inst_to_dict(line))

@rpc("authority", "call_remote", "reliable")
func _start_dialogue(line_dict: Dictionary) -> void:
	var line := dict_to_inst(line_dict) as Dialogue.Line
	game.start_dialogue(line)

func continue_dialogue(line: Dialogue.Line) -> void:
	_continue_dialogue.rpc(inst_to_dict(line))

@rpc("authority", "call_remote", "reliable")
func _continue_dialogue(line_dict: Dictionary) -> void:
	var line := dict_to_inst(line_dict) as Dialogue.Line
	game.continue_dialogue(line)

func end_dialogue() -> void:
	_end_dialogue.rpc()

@rpc("authority", "call_remote", "reliable")
func _end_dialogue() -> void:
	game.end_dialogue()


#==================Game State====================
func update_game(state: Game.GameState) -> void:
	_update_game.rpc(inst_to_dict(state))

@rpc("authority", "call_remote", "reliable")
func _update_game(state: Dictionary) -> void:
	var game_state = dict_to_inst(state) as Game.GameState
	game_updated.emit(game_state)
	

#==================Character Select====================
func select_character(character: Game.Character) -> void:
	game.set_character(character)
	Server.select_character(character)
		
#==================Interactions====================
func complete_interaction(interact_id: String) -> void:
	_complete_interaction.rpc(interact_id)

@rpc("authority", "call_remote", "reliable")
func _complete_interaction(interact_id: String) -> void:
	game.complete_interaction(interact_id)

#==================Cameras====================
@rpc("authority", "call_remote", "reliable")
func switch_camera(camera: CameraManager.Camera) -> void:
	Services.camera.client_switch_camera(camera)

#==================Shelf====================
@rpc("authority", "call_remote", "reliable")
func activate_shelf() -> void:
	Services.shelf.client_activate()

@rpc("authority", "call_remote", "reliable")
func deactivate_shelf() -> void:
	Services.shelf.client_deactivate()

#==================Cameras====================
@rpc("authority", "call_remote", "reliable")
func set_placement(placement: Placement.Type) -> void:
	Services.placement.client_set(placement)

#==================Players====================
func register_player(player: Player) -> void:
	game.player = player
	Server.register_player(game.character)

@rpc("authority", "call_remote", "reliable")
func set_player_active(active: bool) -> void:
	Services.players.client_activate(active)
