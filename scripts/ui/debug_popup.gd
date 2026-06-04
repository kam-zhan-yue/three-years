class_name DebugPopup
extends Control

@onready var name_text := %Name as RichTextLabel
@onready var id_text := %ID as RichTextLabel

func _ready() -> void:
	name_text.text = ""
	id_text.text = ""

func _process(_delta: float) -> void:
	if Client.game == null or Client.game.player == null: return
	name_text.text = Dialogue.SPEAKERS[Client.game.character]
	id_text.text = Client.game.player.name
