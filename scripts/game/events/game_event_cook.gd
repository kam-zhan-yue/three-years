class_name GameEventCook extends GameEvent

func start() -> void:
	# Connect Signals
	Services.dialogue.dialogue_ended.connect(_end)
	Services.dialogue.event_triggered.connect(_event_triggered)
	Services.shelf.server_ingredient_selected.connect(_ingredient_selected)

	Services.dialogue.server_start(DialogueCookLunch.new())

func _event_triggered(event: Dialogue.Event) -> void:
	if event == Dialogue.Event.Ingredients:
		Services.camera.server_switch_camera(Game.Character.Wato, CameraManager.Camera.Shelf)
		Services.shelf.server_activate(Game.Character.Wato)

func _ingredient_selected(type: String) -> void:
	Services.dialogue.server_respond(Game.Character.Wato, type)
	Services.camera.server_switch_camera(Game.Character.Wato, CameraManager.Camera.Main)
	Global.print("Ingredient Selected: %s" % type)

func _end() -> void:
	# Disconnect Signals
	Services.dialogue.dialogue_ended.disconnect(_end)
	Services.dialogue.event_triggered.disconnect(_event_triggered)
	Services.shelf.server_ingredient_selected.disconnect(_ingredient_selected)
	end()
