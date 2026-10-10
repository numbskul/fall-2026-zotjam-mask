extends Control

@onready var label: Label = $CanvasLayer/MarginContainer2/Label
@onready var mask_container: MarginContainer = $CanvasLayer/MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_mask_visible(val : bool):
	mask_container.visible = val
	

func update_timer_label(time : int):
	var minutes = time / 60
	var seconds = time % 60
	label.text = str(minutes) + ":" + str(seconds)
