class_name Spawner
extends MultiplayerSpawner

@export var network_player: PackedScene

func spawn_player(id: int) -> Player:
	var player: Player = network_player.instantiate() as Player
	player.name = str(id)
	get_node(spawn_path).call_deferred("add_child", player)
	return player
