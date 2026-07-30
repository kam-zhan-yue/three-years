class_name DialogueEventDerekCleaned extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Wato, "Ahh so much better."),
		Dialogue.Line.new(Game.Character.Alex, "I'm sure he preferred the floor, like you."),
		Dialogue.Line.new(Game.Character.Wato, "That's why I have custody over him and you don't"),
		Dialogue.Line.new(Game.Character.Alex, "Fair."),
	]
