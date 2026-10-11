extends Node

@onready var start_position: Marker2D = $Node2D/StartPosition
@onready var timer: Timer = $Timer
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@export var fade_to_white_curve : Curve
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

func _ready() -> void:
	player.global_position = start_position.global_position

func _process(delta: float) -> void:
	if timer.time_left < 15:
		screenshake(remap(timer.time_left, 15, 0, 0, 1))
	if timer.time_left < 2:
		fade_to_white(remap(timer.time_left, 2, 0, 0, 1))
	
func screenshake(intensity : float) -> void:
	var rand_x := randf_range(intensity, 2 * intensity)
	var rand_y := randf_range(intensity, 2 * intensity)
	camera_2d.offset = Vector2(rand_x, rand_y)

func fade_to_white(progress : float) -> void:
	var alpha := fade_to_white_curve.sample_baked(progress) * 255
	color_rect.color.a = alpha

func _on_main_timer_timeout() -> void:
	pass # Replace with function body.
