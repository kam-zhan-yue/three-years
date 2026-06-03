class_name Dialogue

enum Event {
	Clean,
	Cook,
	Eat,
}

class Line:
	var speaker: Game.Character
	var body: String

	func _init(s: Game.Character, b: String) -> void:
		speaker = s
		body = b

var DIALOGUES: Dictionary[Event, DialogueScript] = {
	Event.Clean: ScriptCleanRoom.new(),
	Event.Cook: ScriptCookLunch.new(),
	Event.Eat: ScriptEatLunch.new(),
}
