class_name Game

# Struct-like data structure to represent the game
class GameState:
	var players: Dictionary[int, Game.Character]

enum Character {
	Alex,
	Wato,
}

enum EventType {
	Dialogue,
	Game
}

enum Event {
	Clean,
	Cook,
	Eat,
}

var DIALOGUES: Dictionary[Dialogue.Event, DialogueScript] = {
	Dialogue.Event.Clean: DialogueCleanRoom.new(),
	Dialogue.Event.Cook: DialogueCookLunch.new(),
	Dialogue.Event.Eat: DialogueEatLunch.new(),
}

var EVENTS: Dictionary[Event, GameEvent] = {
	Event.Clean: GameEventClean.new(),
	Event.Cook: GameEventCook.new(),
	Event.Eat: GameEventEat.new(),
}

var FLOW := [
	Global.dialogue_event(Dialogue.Event.Clean),
	Global.game_event(Event.Clean),
	Global.dialogue_event(Dialogue.Event.Cook),
	Global.game_event(Event.Cook),
	Global.dialogue_event(Dialogue.Event.Eat),
	Global.game_event(Event.Eat),
]
