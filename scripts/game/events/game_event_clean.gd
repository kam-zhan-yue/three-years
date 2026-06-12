class_name GameEventClean extends GameEvent

func start() -> void:
	Services.dialogue.server_start(DialogueCleanRoom.new())
	await Services.dialogue.dialogue_ended
	Services.interact.server_activate()
	await Services.interact.on_completed
	end()
