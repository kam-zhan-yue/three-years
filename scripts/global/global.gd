extends Node

func print(text: String) ->  void:
	var authority := "SERVER" if multiplayer.is_server() else "CLIENT"
	print("%s-%s | %s" % [authority, multiplayer.get_unique_id(), text])


func set_active(node: Node) -> void:
	_active(node, true)
	
func set_inactive(node: Node) -> void:
	_active(node, false)

func _active(node: Node, is_active: bool) -> void:
	# Set visibility
	node.visible = is_active
	
	# Set general processing
	node.set_process(is_active)
	
	# Set physics processing
	node.set_physics_process(is_active)
	
	# Optionally, set input processing if needed
	if node.has_method("set_process_input"):
		node.set_process_input(is_active)
	
	# Optionally, set unhandled input processing if needed
	if node.has_method("set_process_unhandled_input"):
		node.set_process_unhandled_input(is_active)
