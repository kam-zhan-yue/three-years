class_name Dialogue

const SPEAKERS: Dictionary[Game.Character, String] = {
	Game.Character.Alex: "Alex",
	Game.Character.Wato: "Wato",
}

class Line:
	var speaker: Game.Character
	var body: String

	func _init(s: Game.Character, b: String) -> void:
		speaker = s
		body = b
