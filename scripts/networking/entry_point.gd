class_name EntryPoint
extends Node

func _ready() -> void:
	if OS.has_feature("dedicated_server"):
		Server.start_server()
