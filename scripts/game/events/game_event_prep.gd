class_name GameEventPrep extends GameEvent

var placements := 0

func start() -> void:
	placements = 0
	Services.players.server_activate_all(false)
	Services.dialogue.server_start(DialoguePrep.new())
	await Services.dialogue.dialogue_ended

	Services.players.server_activate_all(true)
	Services.placement.server_set(Game.Character.Alex, Placement.Type.Kitchen)
	Services.placement.server_set(Game.Character.Wato, Placement.Type.Shelf)

	for i in range(2):
		await Services.placement.server_placement_completed

	end()
