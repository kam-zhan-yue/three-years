class_name GameEventEat extends GameEvent

func start() -> void:
	Services.camera.server_activate_zones()
	Services.players.server_activate_all(true)
	Services.placement.server_set(Game.Character.Alex, Placement.Type.FutonAlex)
	Services.placement.server_set(Game.Character.Wato, Placement.Type.FutonWato)
	for i in range(2):
		await Services.placement.server_placement_completed

	Services.players.server_activate_all(false)

	Services.dialogue.event_triggered.connect(_event_triggered)
	Services.dialogue.server_start(DialogueEatLunch.new())
	await Services.dialogue.dialogue_ended

	Services.dialogue.event_triggered.disconnect(_event_triggered)
	Services.kotatsu.server_end_screen()
	end()

func _event_triggered(event: Dialogue.Event) -> void:
	if event == Dialogue.Event.ShowPasta:
		Services.kotatsu.server_show_pasta()
	elif event == Dialogue.Event.HidePasta:
		Services.kotatsu.server_hide_pasta()
