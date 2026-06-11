class_name InteractablePopup
extends Node

@onready var synchronizer := %MultiplayerSynchronizer as MultiplayerSynchronizer
@onready var progress_bar := %ProgressBar as ProgressBar
@onready var tooltip := %Tooltip as Control

var show_tooltip := false

var interactable: Interactable

func _ready() -> void:
	Global.set_inactive(progress_bar)
	Global.set_inactive(tooltip)

func init(i: Interactable) -> void:
	interactable = i
	synchronizer.delta_synchronized.connect(_synchronized)
	progress_bar.min_value = 0
	progress_bar.max_value = interactable.initial_progress


func hover_start() -> void:
	if !interactable.completed and !interactable.interacting:
		show_tooltip = true
		Global.set_active(tooltip)

func hover_stop() -> void:
	show_tooltip = false
	Global.set_inactive(tooltip)

# I wonder if this is really a good way of doing things?
func _synchronized() -> void:
	if interactable.completed:
		Global.set_inactive(tooltip)
		Global.set_inactive(progress_bar)
		return

	if interactable.interacting:
		Global.set_inactive(tooltip)
		Global.set_active(progress_bar)
	else: 
		Global.set_inactive(progress_bar)
		if show_tooltip:
			Global.set_active(tooltip)
	
	progress_bar.value = interactable.progress
