extends Control

@onready var label: Label = $CanvasLayer/MarginContainer2/Label
@onready var mask_container: MarginContainer = $CanvasLayer/MarginContainer
@onready var dynamic_mask: AnimatedSprite2D = $CanvasLayer/MarginContainer/Control/DynamicMask

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_mask_visible(val : bool):
	mask_container.visible = val

func update_mask(dict : Dictionary) -> void:
	dynamic_mask.set_mask(dict)

func update_timer_label(time : int):
	var minutes = str(time / 60)
	var seconds = str(time % 60) if time % 60 > 9 else str(0) + str(time % 60)
	label.text = minutes + ":" + seconds
