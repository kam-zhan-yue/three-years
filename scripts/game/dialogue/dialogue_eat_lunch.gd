class_name DialogueEatLunch extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		# == Kotatsu Talk
		Dialogue.Line.new(Game.Character.Alex, "Ahhh, I love this seat.")
			.with_camera(CameraManager.Camera.Kotatsu),
		Dialogue.Line.new(Game.Character.Wato, "Your posture is always terrible on it though."),
		Dialogue.Line.new(Game.Character.Alex, "Yeah, I'm gonna have irreparable back pain in a few years."),
		Dialogue.Line.new(Game.Character.Alex, "But it's so comfortable!"),

		# ==N atto Pasta
		Dialogue.Line.new(Game.Character.Alex, "Anyways... drum roll please..."),
		Dialogue.Line.new(Game.Character.Alex, "Tada!")
			.with_event(Dialogue.Event.ShowPasta),
		Dialogue.Line.new(Game.Character.Wato, "I can't want to dig in.")
			.with_camera(CameraManager.Camera.PastaZoom),
		Dialogue.Line.new(Game.Character.Wato, "The musky smell of the natto really complements the plainness of the pasta."),
		Dialogue.Line.new(Game.Character.Wato, "It's gonna be absolutely delicious."),
		Dialogue.Line.new(Game.Character.Alex, "Itadakimasu!")
			.with_camera(CameraManager.Camera.Kotatsu),
		Dialogue.Line.new(Game.Character.None, "Alex and Wato dig into their scrumptious meal of natto pasta."),
		Dialogue.Line.new(Game.Character.Wato, "Mmm that was... interesting.")
			.with_event(Dialogue.Event.HidePasta),
		Dialogue.Line.new(Game.Character.Alex, "It wasn't completely bad!"),
		Dialogue.Line.new(Game.Character.Alex, "The bitterness and copious amounts of oil work together."),
		Dialogue.Line.new(Game.Character.Wato, "And the texture! Loved the sliminess with the pasta."),
		Dialogue.Line.new(Game.Character.Alex, "..."),
		Dialogue.Line.new(Game.Character.Wato, "..."),
		Dialogue.Line.new(Game.Character.Alex, "Let's not do this again."),
		Dialogue.Line.new(Game.Character.Wato, "That was absolutely horrible."),
		Dialogue.Line.new(Game.Character.Alex, "But anything tastes amazing when I eat it with you."),
		Dialogue.Line.new(Game.Character.Wato, "That's so corny."),
		Dialogue.Line.new(Game.Character.Wato, "But do I love corn."), Dialogue.Line.new(Game.Character.Alex, "That you do."),

		# == Wrapping up

		Dialogue.Line.new(Game.Character.Wato, "I wish life could continue just like this.")
			.with_camera(CameraManager.Camera.KotatsuWato),
		Dialogue.Line.new(Game.Character.Wato, "Cleaning up our clothes in the room that we live in."),
		Dialogue.Line.new(Game.Character.Wato, "Cooking random things in our pantry together."),
		Dialogue.Line.new(Game.Character.Wato, "Eating it together on our table."),
		Dialogue.Line.new(Game.Character.Alex, "You hate cooking with me.")
			.with_camera(CameraManager.Camera.KotatsuAlex),
		Dialogue.Line.new(Game.Character.Wato, "I do.")
			.with_camera(CameraManager.Camera.KotatsuWato),
		Dialogue.Line.new(Game.Character.Alex, "But I love doing things with you.")
			.with_camera(CameraManager.Camera.KotatsuAlex),
		Dialogue.Line.new(Game.Character.Alex, "And I want this simple life to just continue forever."),
		Dialogue.Line.new(Game.Character.Alex, "I wanna do my everyday boring stuff with you by my side."),
		Dialogue.Line.new(Game.Character.Alex, "Because I love you."),
		Dialogue.Line.new(Game.Character.Wato, "I love you too.")
			.with_camera(CameraManager.Camera.KotatsuWato),
		Dialogue.Line.new(Game.Character.Alex, "Happy 3 years.")
			.with_camera(CameraManager.Camera.KotatsuAlex),
		Dialogue.Line.new(Game.Character.Wato, "Happy 3 years.")
			.with_camera(CameraManager.Camera.KotatsuWato),
		Dialogue.Line.new(Game.Character.Wato, "Thanks for being here with me."),
		Dialogue.Line.new(Game.Character.Alex, "Thanks for putting up with me.")
			.with_camera(CameraManager.Camera.KotatsuAlex),
		Dialogue.Line.new(Game.Character.Alex, "Do you wanna watch something?")
			.with_camera(CameraManager.Camera.Kotatsu),
		Dialogue.Line.new(Game.Character.Wato, "That sounds lovely."),
	]
