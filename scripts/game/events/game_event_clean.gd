class_name GameEventClean extends GameEvent

func start() -> void:
	Services.players.server_set_anim(Player.AnimState.Sitting)
	Services.players.server_activate_all(false)
	# Services.dialogue.server_start(DialogueCleanRoom.new())
	# await Services.dialogue.dialogue_ended

	Services.players.server_set_anim(Player.AnimState.Standing)
	Services.interact.server_activate()
	Services.players.server_activate_all(true)
	Services.camera.server_activate_zones()
	await Services.interact.on_completed
	end()
