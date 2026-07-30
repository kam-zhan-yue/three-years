class_name DialogueEventLaundryCleaned extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Wato, "The room feels so much better with no clothes on the floor."),
		Dialogue.Line.new(Game.Character.Alex, "How do this many clothes always end up on the floor anyways?"),
		Dialogue.Line.new(Game.Character.Wato, "I guess we'll never know."),
	]
