class_name InteractablePopup
extends Node

@onready var synchronizer := %MultiplayerSynchronizer as MultiplayerSynchronizer
@onready var progress_bar := %ProgressBar as ProgressBar

@onready var canvas := %Canvas as Sprite3D

var interactable: Interactable

func _ready() -> void:
	Global.set_inactive(canvas)

func init(i: Interactable) -> void:
	interactable = i
	synchronizer.synchronized.connect(_synchronized)
	progress_bar.min_value = 0
	progress_bar.max_value = interactable.initial_progress


# I wonder if this is really a good way of doing things?
func _synchronized() -> void:
	if interactable.interacting:
		Global.set_active(canvas)
	else: 
		Global.set_inactive(canvas)
	
	progress_bar.value = interactable.progress
