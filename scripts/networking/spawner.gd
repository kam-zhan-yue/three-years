class_name Spawner
extends MultiplayerSpawner

@export var network_player: PackedScene
@export var wato: PackedScene
@export var alex: PackedScene

var players = []

func spawn_player(id: int, character: Game.Character) -> Player:
	var player: Player
	match character:
		Game.Character.Wato:
			player = wato.instantiate() as Player
		Game.Character.Alex:
			player = alex.instantiate() as Player
		_:
			Global.error("Couldn't spawn %s with character %s" % [id, Global.get_character_name(character)])
			return
	player.name = str(id)
	get_node(spawn_path).call_deferred("add_child", player)
	players.append(player)
	return player

func despawn_all() -> void:
	for player in players:
		player.queue_free()
	players = []
