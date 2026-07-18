class_name DialogueEatLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		# Kotatsu Talk
		Dialogue.Line.new(Game.Character.Alex, "Ahhh, I love this seat."),
		Dialogue.Line.new(Game.Character.Wato, "Your posture is always terrible on it though."),
		Dialogue.Line.new(Game.Character.Alex, "Yeah, I'm gonna have irreparable back pain in a few years."),
		Dialogue.Line.new(Game.Character.Alex, "But it's so comfortable!"),

		# Natto Pasta
		Dialogue.Line.new(Game.Character.Wato, "I can't want to dig in."),
		Dialogue.Line.new(Game.Character.Wato, "The musky smell of the natto really complements the plainness of the pasta."),
		Dialogue.Line.new(Game.Character.Wato, "It's gonna be absolutely delicious."),
		Dialogue.Line.new(Game.Character.Alex, "Itadakimasu!"),
		Dialogue.Line.new(Game.Character.None, "Alex and Wato dig into their scrumptious meal of natto pasta."),
		Dialogue.Line.new(Game.Character.Wato, "Mmm that was... interesting."),
		Dialogue.Line.new(Game.Character.Alex, "It wasn't completely bad!"),
		Dialogue.Line.new(Game.Character.Alex, "The bitterness and copious amounts of oil work together."),
		Dialogue.Line.new(Game.Character.Wato, "And the texture! Loved the sliminess with the pasta."),
		Dialogue.Line.new(Game.Character.Alex, "..."),
		Dialogue.Line.new(Game.Character.Wato, "..."),
		Dialogue.Line.new(Game.Character.Alex, "Let's not do this again."),
		Dialogue.Line.new(Game.Character.Wato, "That was absolutely horrible."),
		Dialogue.Line.new(Game.Character.Alex, "But anything tastes amazing when I eat it with you."),
		Dialogue.Line.new(Game.Character.Wato, "That's so corny."),
		Dialogue.Line.new(Game.Character.Wato, "But do I love corn."),
		Dialogue.Line.new(Game.Character.Alex, "That you do."),

		# Wrapping up
		Dialogue.Line.new(Game.Character.Wato, "I wish life could continue just like this.")
			.with_event(Dialogue.Event.DeepTalk),
		Dialogue.Line.new(Game.Character.Wato, "Cleaning up our clothes in the room that we live in."),
		Dialogue.Line.new(Game.Character.Wato, "Cooking random things in our pantry together."),
		Dialogue.Line.new(Game.Character.Wato, "Eating it togehter on our table."),
		Dialogue.Line.new(Game.Character.Alex, "You hate cooking with me."),
		Dialogue.Line.new(Game.Character.Wato, "I do."),
		Dialogue.Line.new(Game.Character.Alex, "But I love doing things with you."),
		Dialogue.Line.new(Game.Character.Alex, "And I want this simple life to just continue forever."),
		Dialogue.Line.new(Game.Character.Alex, "I wanna do my everyday boring stuff with you by my side."),
		Dialogue.Line.new(Game.Character.Alex, "Because I love you."),
		Dialogue.Line.new(Game.Character.Wato, "I love you too."),
		Dialogue.Line.new(Game.Character.Alex, "Happy 3 years."),
		Dialogue.Line.new(Game.Character.Wato, "Happy 3 years."),
		Dialogue.Line.new(Game.Character.Wato, "That sounds lovely."),
		Dialogue.Line.new(Game.Character.Wato, "Thanks for being here with me."),
		Dialogue.Line.new(Game.Character.Alex, "Thanks for putting up with me."),
		Dialogue.Line.new(Game.Character.Alex, "Do you wanna watch something?"),
		Dialogue.Line.new(Game.Character.Wato, "That sounds lovely."),
	]
