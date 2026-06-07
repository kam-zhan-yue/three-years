class_name Dialogue

const SPEAKERS: Dictionary[Game.Character, String] = {
	Game.Character.None: "N/A",
	Game.Character.Alex: "Alex",
	Game.Character.Wato: "Wato",
}

enum Event {
	None,
	Ingredients,
}

class Response:
	var from: Game.Character = Game.Character.None
	var ids: Array[String] = []

	func _init(character: Game.Character, responses: Array[String]) -> void:
		from = character
		ids = responses

class Line:
	var event := Event.None
	var speaker := Game.Character.None
	var body := ""
	var response: Response

	func _init(s: Game.Character, b: String) -> void:
		speaker = s
		body = b

	func with_response(r: Response) -> Line:
		response = r
		return self

	func with_event(e: Event) -> Line:
		event = e
		return self
