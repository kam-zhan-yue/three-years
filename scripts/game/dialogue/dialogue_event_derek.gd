class_name DialogueEventDerek extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Wato, "Derek is on the floor again!"),
		Dialogue.Line.new(Game.Character.Alex, "That's exactly where he loves sleeping."),
		Dialogue.Line.new(Game.Character.Wato, "He's gonna get so dirty, best to put him on the bed."),
	]
