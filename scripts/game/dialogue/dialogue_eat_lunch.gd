class_name DialogueEatLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "Ahhh, I love this seat."),
		Dialogue.Line.new(Game.Character.Wato, "Your posture is always terrible on it though."),
		Dialogue.Line.new(Game.Character.Alex, "Yeah, I'm gonna have irreparable back pain in a few years."),
		Dialogue.Line.new(Game.Character.Alex, "But it's so comfortable!"),
		Dialogue.Line.new(Game.Character.Wato, "I can't want to dig in."),
		Dialogue.Line.new(Game.Character.None, ""),
	]
