class_name GameEventClean extends GameEvent

func start() -> void:
	Services.dialogue.server_start(DialogueCleanRoom.new())
	Services.dialogue.dialogue_ended.connect(_start_interact)

func _start_interact() -> void:
	Services.dialogue.dialogue_ended.disconnect(_start_interact)
	Services.interact.server_activate()
	Services.interact.on_completed.connect(_end)

func _end() -> void:
	Services.interact.on_completed.disconnect(_end)
	end()
