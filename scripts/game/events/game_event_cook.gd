class_name GameEventCook extends GameEvent

func start() -> void:
	# Connect Signals
	Services.dialogue.event_triggered.connect(_event_triggered)
	Services.shelf.server_ingredient_selected.connect(_ingredient_selected)

	# Play Dialogue
	Services.players.server_activate_all(false)
	Services.dialogue.server_start(DialogueCookLunch.new())
	await Services.dialogue.dialogue_ended

	# Reset Cameras
	Services.camera.server_switch_camera(Game.Character.Wato, CameraManager.Camera.Zone)

	# Disconnect Signals
	Services.dialogue.event_triggered.disconnect(_event_triggered)
	Services.shelf.server_ingredient_selected.disconnect(_ingredient_selected)
	end()

func _event_triggered(event: Dialogue.Event) -> void:
	if event == Dialogue.Event.Ingredients:
		Services.camera.server_switch_camera(Game.Character.Wato, CameraManager.Camera.Shelf)
		Services.shelf.server_activate(Game.Character.Wato)

func _ingredient_selected(type: String) -> void:
	Services.dialogue.server_respond(Game.Character.Wato, type)
	Global.print("Ingredient Selected: %s" % type)
