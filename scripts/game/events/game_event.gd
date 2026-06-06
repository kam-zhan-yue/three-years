@abstract class_name GameEvent

@abstract func start() -> void

signal ended

func end() -> void:
	ended.emit()
