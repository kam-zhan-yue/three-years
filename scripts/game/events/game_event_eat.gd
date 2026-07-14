class_name GameEventEat extends GameEvent

func start() -> void:
	Services.players.server_activate_all(true)
	Services.placement.server_set(Game.Character.Alex, Placement.Type.FutonAlex)
	Services.placement.server_set(Game.Character.Wato, Placement.Type.FutonWato)
	for i in range(2):
		await Services.placement.server_placement_completed

	Services.players.server_activate_all(false)
	Services.dialogue.server_start(DialogueEatLunch.new())
	await Services.dialogue.dialogue_ended
	end()
