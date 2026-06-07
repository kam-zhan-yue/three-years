class_name DialogueCookLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line
			.new(Game.Character.Alex, "Could you pass me the salt?")
			.with_event(Dialogue.Event.Ingredients)
			.with_response(Dialogue.Response.new(Game.Character.Wato, ["SALT", "PEPPER"])),
		Dialogue.Line.new(Game.Character.Wato, "Here you go!")
	]
