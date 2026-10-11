extends Node

@onready var start_position: Marker2D = $Node2D/StartPosition
@onready var timer: Timer = $Timer
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: CharacterBody2D = $Player
@export var fade_to_white_curve : Curve
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var mask_changer: Node2D = $"Mask Changer"
@export var screenshake_intensity := 0.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player.global_position = start_position.global_position

func _process(delta: float) -> void:		
	if timer.time_left <= 15:
		if !animation_player.is_playing():
			animation_player.play("bomb_explodes")
		screenshake(screenshake_intensity)
		
	
func screenshake(intensity : float) -> void:
	var rand_x := randf_range(intensity, 2 * intensity)
	var rand_y := randf_range(intensity, 2 * intensity)
	camera_2d.offset = Vector2(rand_x, rand_y)

func fade_to_white(progress : float) -> void:
	var alpha := fade_to_white_curve.sample_baked(progress)
	color_rect.color.a = alpha

func _on_main_timer_timeout() -> void:
	pass # Replace with function body.


func _on_player_restart_loop() -> void:
	mask_changer.close_ui(false)
	PlayerMaskData.reset_mask()
	player.global_position = start_position.global_position
	timer.start(0)
