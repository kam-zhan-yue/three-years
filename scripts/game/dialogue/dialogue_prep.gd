class_name DialoguePrep extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "I'm famished."),
		Dialogue.Line.new(Game.Character.Wato, "Me too."),
		Dialogue.Line.new(Game.Character.Alex, "Time to make some lunch! I'll go to the kitchen, can you help prep?"),
		Dialogue.Line.new(Game.Character.Wato, "Sounds good!"),
	]
