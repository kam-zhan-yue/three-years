class_name GameEventCook extends GameEvent

func start() -> void:
	Services.dialogue.dialogue_ended.connect(_end)
	Services.dialogue.event_triggered.connect(_event_triggered)
	Services.dialogue.server_start(DialogueCookLunch.new())

func _event_triggered(event: Dialogue.Event) -> void:
	if event == Dialogue.Event.Ingredients:
		Server.switch_camera(Game.Character.Wato, CameraManager.Camera.Shelf)

func _end() -> void:
	Services.dialogue.dialogue_ended.disconnect(_end)
	Services.dialogue.event_triggered.disconnect(_event_triggered)
	end()
