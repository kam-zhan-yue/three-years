class_name GameEventClean extends GameEvent

func start() -> void:
	Services.players.server_set_anim(Player.AnimState.Sitting)
	Services.dialogue.server_start(DialogueCleanRoom.new())
	Services.players.server_activate_all(false)
	await Services.dialogue.dialogue_ended
	Services.players.server_set_anim(Player.AnimState.Standing)
	Services.interact.server_activate()
	Services.players.server_activate_all(true)
	await Services.interact.on_completed
	end()
