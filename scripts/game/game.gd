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
	Prep,
}

var EVENTS: Dictionary[Event, GameEvent] = {
	Event.Clean: GameEventClean.new(),
	Event.Prep: GameEventPrep.new(),
	Event.Cook: GameEventCook.new(),
	Event.Eat: GameEventEat.new(),
}

var FLOW: Array[Event] = [
	Event.Eat,
	Event.Cook,
	Event.Clean,
	Event.Prep,
]
