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

enum DialogueEvent {
	Derek,
	DerekCleaned,
	Ukelele,
	LaundryCleaned,
}

var DIALOGUE_EVENTS: Dictionary[DialogueEvent, DialogueScript] = {
	DialogueEvent.Derek: DialogueEventDerek.new(),
	DialogueEvent.DerekCleaned: DialogueEventDerekCleaned.new(),
	DialogueEvent.Ukelele: DialogueEventUkelele.new(),
	DialogueEvent.LaundryCleaned: DialogueEventLaundryCleaned.new(),
}

var EVENTS: Dictionary[Event, GameEvent] = {
	Event.Clean: GameEventClean.new(),
	Event.Prep: GameEventPrep.new(),
	Event.Cook: GameEventCook.new(),
	Event.Eat: GameEventEat.new(),
}

# var FLOW: Array[Event] = [
# 	Event.Clean,
# 	Event.Prep,
# 	Event.Cook,
# 	Event.Eat,
# ]

var play_dialogue := false

var FLOW: Array[Event] = [
	Event.Cook,
	Event.Eat,
]
