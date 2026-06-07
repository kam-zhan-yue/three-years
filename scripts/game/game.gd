class_name Game

# Struct-like data structure to represent the game
class GameState:
	var players: Dictionary[int, Game.Character]

enum Character {
	None,
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

var EVENTS: Dictionary[Event, GameEvent] = {
	Event.Clean: GameEventClean.new(),
	Event.Cook: GameEventCook.new(),
	Event.Eat: GameEventEat.new(),
}

var FLOW: Array[Event] = [
	Event.Cook,
	Event.Clean,
	Event.Eat,
]
