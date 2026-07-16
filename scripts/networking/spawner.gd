class_name Spawner
extends MultiplayerSpawner

@export var network_player: PackedScene

var players = []

func spawn_player(id: int) -> Player:
	var player := network_player.instantiate() as Player
	player.name = str(id)
	get_node(spawn_path).call_deferred("add_child", player)
	players.append(player)
	return player

func despawn_all() -> void:
	for player in players:
		player.queue_free()
	players = []
