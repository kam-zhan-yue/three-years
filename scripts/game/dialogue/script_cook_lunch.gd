class_name ScriptCookLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "Ahhh cooking cooking"),
		Dialogue.Line.new(Game.Character.Wato, "So much meat!")
	]
