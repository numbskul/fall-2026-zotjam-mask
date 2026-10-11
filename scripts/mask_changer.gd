extends Node2D

## Mask Changer Object Code

@onready var canvas_layer: CanvasLayer = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("mask_changer")
	canvas_layer.visible = false

## Mask UI Code

@onready var black: Button = $CanvasLayer/Control/Control/VBoxContainer/HBoxContainer/Black
@onready var red: Button = $CanvasLayer/Control/Control/VBoxContainer/HBoxContainer/Red
@onready var blue: Button = $CanvasLayer/Control/Control/VBoxContainer/HBoxContainer/Blue
@onready var green: Button = $CanvasLayer/Control/Control/VBoxContainer/HBoxContainer/Green
@onready var dynamic_mask: AnimatedSprite2D = $CanvasLayer/Control/CenterContainer/Control/DynamicMask

var new_mask_dict : Dictionary = PlayerMaskData.mask_dict.duplicate()
enum COLORS {BLACK, RED, BLUE, GREEN}
var current_color := COLORS.BLACK

func open_ui():
	new_mask_dict = PlayerMaskData.mask_dict.duplicate()
	update_display_mask()
	canvas_layer.visible = true

func close_ui(save : bool):
	if save:
		PlayerMaskData.mask_dict = new_mask_dict
		for item in new_mask_dict:
			MadTalkGlobals.set_variable(item, str(new_mask_dict[item]))
	canvas_layer.visible = false
	PlayerMaskData.done_editing_mask.emit()
	current_color = COLORS.BLACK

func change_var(v : int, ch := 1) -> int:
	return (v + ch) % 4

func update_display_mask() -> void:
	dynamic_mask.set_mask(new_mask_dict)

func _on_emblem_left() -> void:
	new_mask_dict["emblem_shape"] = change_var(new_mask_dict["emblem_shape"], -1)
	update_display_mask()
	
func _on_emblem_right() -> void:
	new_mask_dict["emblem_shape"] = change_var(new_mask_dict["emblem_shape"])
	update_display_mask()

func _on_eyes_left() -> void:
	new_mask_dict["eye_shape"] = change_var(new_mask_dict["eye_shape"], -1)
	update_display_mask()

func _on_eyes_right() -> void:
	new_mask_dict["eye_shape"] = change_var(new_mask_dict["eye_shape"])
	update_display_mask()

func _on_mouth_left() -> void:
	new_mask_dict["mouth_shape"] = change_var(new_mask_dict["eye_shape"], -1)
	update_display_mask()

func _on_mouth_right() -> void:
	new_mask_dict["mouth_shape"] = change_var(new_mask_dict["mouth_shape"])
	update_display_mask()

func _on_black_pressed() -> void:
	current_color = COLORS.BLACK
	red.button_pressed = false
	blue.button_pressed = false
	green.button_pressed = false

func _on_red_pressed() -> void:
	current_color = COLORS.RED
	black.button_pressed = false
	blue.button_pressed = false
	green.button_pressed = false

func _on_blue_pressed() -> void:
	current_color = COLORS.BLUE
	black.button_pressed = false
	red.button_pressed = false
	green.button_pressed = false

func _on_green_pressed() -> void:
	current_color = COLORS.GREEN
	black.button_pressed = false
	red.button_pressed = false
	blue.button_pressed = false

func _emblem_assign_color() -> void:
	new_mask_dict["emblem_color"] = current_color as MaskResource.EMBLEM_COLOR
	update_display_mask()

func eyes_assign_color() -> void:
	new_mask_dict["eye_color"] = current_color as MaskResource.EYE_COLOR
	update_display_mask()

func _mouth_assign_color() -> void:
	new_mask_dict["mouth_color"] = current_color as MaskResource.MOUTH_COLOR
	update_display_mask()

func _on_confirm_button_down() -> void:
	close_ui(true)

func _on_cancel_button_down() -> void:
	close_ui(false)
