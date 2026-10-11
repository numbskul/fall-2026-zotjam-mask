extends Node2D


enum FACINGS {DOWN, LEFT, RIGHT, BACK}
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var dialog_id := ""
@export var spritesheet : SpriteFrames
@export var facing := FACINGS.DOWN

func _ready() -> void:
	add_to_group("npc")
	animated_sprite_2d.sprite_frames = spritesheet
	animated_sprite_2d.set_frame_and_progress(facing, 0.0)
	
func get_dialog_id() -> String:
	return dialog_id
