class_name GameEventClean extends GameEvent

var interact_manager: InteractManager

func start() -> void:
	interact_manager.server_activate()
	interact_manager.on_completed.connect(end)
