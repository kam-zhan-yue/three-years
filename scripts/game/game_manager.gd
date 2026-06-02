class_name GameManager
extends Node

var counter := 0.0
var timer := 0

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected)

func _on_connected() -> void:
	Global.print("Connected!")

func _process(delta: float) -> void:
	if multiplayer.is_server():
		counter += delta
		if int(counter) > timer:
			print_message.rpc(str(int(counter)))
			timer += 1


func _unhandled_input(event: InputEvent) -> void:
	if multiplayer.is_server(): return
	if event.is_action_pressed("ui_accept"):
		update_server.rpc_id(1)
		

@rpc("authority", "call_remote", "reliable")
func print_message(text: String) -> void:
	Global.print("Message Received: %s" % text)

@rpc("any_peer", "call_remote", "reliable")
func update_server() -> void:
	if !multiplayer.is_server(): return
	print_message.rpc("This is a message to everyone from the server!")
