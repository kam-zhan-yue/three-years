class_name ScriptCleanRoom extends DialogueScript

func get_dialogue() -> Array[Dialogue.Line]:
	return [
		Dialogue.Line.new(Game.Character.Alex, "What a great day today is!"),
		Dialogue.Line.new(Game.Character.Wato, "Indeed!")
	]
