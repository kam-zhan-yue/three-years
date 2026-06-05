class_name DialogueEatLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "This is some nice stuff  mm mm "),
		Dialogue.Line.new(Game.Character.Wato, "Aw yeah")
	]
