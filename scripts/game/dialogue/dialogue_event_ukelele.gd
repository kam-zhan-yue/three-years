class_name DialogueEventUkelele extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "Ah yes, the ¥1000 ukelele. I wonder when we'll actually learn to play it."),
		Dialogue.Line.new(Game.Character.Wato, "I'm still not sure if it was a waste of money or not."),
		Dialogue.Line.new(Game.Character.Alex, "Either way, it's an irreplacable part of the apartment now."),
		Dialogue.Line.new(Game.Character.Wato, "That's for sure."),
	]
