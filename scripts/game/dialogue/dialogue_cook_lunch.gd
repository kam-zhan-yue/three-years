class_name DialogueCookLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "All right! Let's get started!"),
		Dialogue.Line.new(Game.Character.Wato, "Let's have a look at what we have.")
			.with_event(Dialogue.Event.Ingredients),
		# Dialogue.Line.new(Game.Character.Wato, "Wow! There's really not much in here!"),
		# Dialogue.Line.new(Game.Character.Alex, "Hahaha, I know right. I didn't do groceries this week."),
		# Dialogue.Line.new(Game.Character.Wato, "Thanks for always getting them."),
		# Dialogue.Line.new(Game.Character.Alex, "I don't know how you stay alive with so little food."),
		# Dialogue.Line.new(Game.Character.Wato, "Pasta and oil have never let me down."),
		# Dialogue.Line.new(Game.Character.Wato, "If you can survive on it, it's good food."),
		# Dialogue.Line.new(Game.Character.Alex, "We're going one step up today, aren't we."),
		# Dialogue.Line.new(Game.Character.Wato, "Natto pasta."),
		# Dialogue.Line.new(Game.Character.Alex, "Natto pasta."),
		Dialogue.Line.new(Game.Character.Alex, "Enough jabbering! Could you pass me something?")
			.with_response(Dialogue.Response.new(Game.Character.Wato, ["Natto", "Pasta", "Milk"])),
		Dialogue.Line.new(Game.Character.Wato, "Here you go!"),
		Dialogue.Line.new(Game.Character.Alex, "Give me something else!")
			.with_response(Dialogue.Response.new(Game.Character.Wato, ["Natto", "Pasta", "Milk"])),
		Dialogue.Line.new(Game.Character.Wato, "Would this work?"),
		Dialogue.Line.new(Game.Character.Alex, "This'll be perfect. I can already smell how good it'll be."),
		Dialogue.Line.new(Game.Character.Alex, "Alright! One more thing!")
			.with_response(Dialogue.Response.new(Game.Character.Wato, ["Natto", "Pasta", "Milk"])),
		Dialogue.Line.new(Game.Character.Wato, "I think this'll go along perfectly"),
		Dialogue.Line.new(Game.Character.Alex, "Dubious choice..."),
		Dialogue.Line.new(Game.Character.Alex, "But I'll make it work!"),
		Dialogue.Line.new(Game.Character.Wato, "Thanks honey."),
		Dialogue.Line.new(Game.Character.Alex, "Oh yeah! I think it's done!")
			.with_event(Dialogue.Event.KitchenTalk),
		Dialogue.Line.new(Game.Character.Wato, "It smells amazing! I wonder if this'll be better than broccoli pasta."),
		Dialogue.Line.new(Game.Character.Alex, "That's gonna be hard to beat. Your broccoli pasta is amazing."),
		Dialogue.Line.new(Game.Character.Wato, "Shall we go eat here on the floor?"),
		Dialogue.Line.new(Game.Character.Alex, "As much as I wanna say yes, I don't think we have a sitting down animation"),
		Dialogue.Line.new(Game.Character.Wato, "To the kotatsu we go."),
		Dialogue.Line.new(Game.Character.Alex, "I'll race you there!"),
	]
