class_name DialoguePrep extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "Oh my gosh that took forever. But the room is looking so much better now!"),
		Dialogue.Line.new(Game.Character.Wato, "I feel like I can finally breathe."),
		Dialogue.Line.new(Game.Character.Wato, "All that work has made me so hungry though!"),
		Dialogue.Line.new(Game.Character.Wato, "I've been famished ever since I got up."),
		Dialogue.Line.new(Game.Character.Alex, "I'll whip something up."),
		Dialogue.Line.new(Game.Character.Wato, "You're an angel."),
		Dialogue.Line.new(Game.Character.Alex, "You might not say that after you finish eating what I make."),
		Dialogue.Line.new(Game.Character.Alex, "From what I saw in the pantry, we barely have ingredients."),
		Dialogue.Line.new(Game.Character.Alex, "I think I only saw natto and pasta last night."),
		Dialogue.Line.new(Game.Character.Wato, "Natto pasta works well for me."),
		Dialogue.Line.new(Game.Character.Alex, "It was surprisingly delicious the last time we had it."),
		Dialogue.Line.new(Game.Character.Wato, "Yeah right."),
		Dialogue.Line.new(Game.Character.Wato, "It should definitely be it's own thing."),
		Dialogue.Line.new(Game.Character.Wato, "Natto pasta."),
		Dialogue.Line.new(Game.Character.Alex, "Natto pasta."),
		Dialogue.Line.new(Game.Character.Wato, "..."),
		Dialogue.Line.new(Game.Character.Alex, "..."),
		Dialogue.Line.new(Game.Character.Alex, "Alright I'll get cooking, do you think you can help me out?"),
		Dialogue.Line.new(Game.Character.Wato, "Of course, what do you need help with?"),
		Dialogue.Line.new(Game.Character.Alex, "I can't cook while getting the ingredients."),
		Dialogue.Line.new(Game.Character.Alex, "It's not in my code."),
		Dialogue.Line.new(Game.Character.Wato, "I'll get them for you!"),
		Dialogue.Line.new(Game.Character.Alex, "Let's head to the kitchen, I'll go to the stove, you go to the shelves."),
	]
