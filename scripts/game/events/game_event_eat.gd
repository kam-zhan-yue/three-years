class_name GameEventEat extends GameEvent

func start() -> void:
	Services.dialogue.server_start(DialogueEatLunch.new())
	await Services.dialogue.ended
	end()
