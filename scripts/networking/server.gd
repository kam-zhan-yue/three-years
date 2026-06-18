extends Node

var peer: ENetMultiplayerPeer
var game: GameServer

signal started
signal player_joined(id: int)

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_connected)

func start() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(Global.PORT)
	multiplayer.multiplayer_peer = peer
	Global.print("Starting Server")
	started.emit()

func init_game(g: GameServer) -> void:
	game = g

# When a peer connects, send them a game update to let them know how it is going
func _on_connected(_id: int) -> void:
	if !multiplayer.is_server(): return
	if !game: return
	game.send_update()


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
	player_joined.emit(id)
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

#==================Dialogue====================
func continue_dialogue(line: Dialogue.Line) -> void:
	_continue_dialogue.rpc_id(1, Global.id(), inst_to_dict(line))

@rpc("any_peer", "call_remote", "reliable")
func _continue_dialogue(client_id: int, line: Dictionary) -> void:
	if !multiplayer.is_server(): return
	Global.debug("Progressing dialogue...")
	
	# Validate that the player can request to continue this dialogue
	var l := dict_to_inst(line) as Dialogue.Line
	var character := game.players[client_id]
	if character != l.speaker: return

	game.continue_dialogue(l)

#==================Camera====================
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
