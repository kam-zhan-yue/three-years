class_name GameEventEat extends GameEvent

func start() -> void:
	Services.dialogue.server_start(DialogueEatLunch.new())
	Services.dialogue.dialogue_ended.connect(_end)

func _end() -> void:
	Services.interact.on_completed.disconnect(_end)
	end()
