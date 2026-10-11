extends CharacterBody2D

@onready var gameplay_ui: Control = $"Gameplay UI"
@onready var dialogue_overlay: Control = $DialogueOverlay
@onready var player_interaction_range: Area2D = $PlayerInteractionRange
@export var movement_speed = 96.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var timer : Timer

enum FACINGS {UP, DOWN, LEFT, RIGHT}
enum STATES {IDLE, MOVING, TALKING, CHANGING_MASK}
var current_facing := FACINGS.DOWN
var current_state := STATES.IDLE

signal restart

@onready var dynamic_mask: AnimatedSprite2D = $DynamicMask

func _ready() -> void:
	PlayerMaskData.done_editing_mask.connect(_on_done_editing)
	pass

func _process(delta: float) -> void:
	gameplay_ui.set_mask_visible(current_state == STATES.MOVING || current_state == STATES.IDLE)
	gameplay_ui.update_timer_label(timer.time_left)
	gameplay_ui.update_mask(PlayerMaskData.mask_dict)
	if current_state != STATES.MOVING:
		if current_facing == FACINGS.UP:
			animated_sprite_2d.play("idle_front")
		elif current_facing == FACINGS.LEFT:
			animated_sprite_2d.play("idle_right")
		elif current_facing == FACINGS.RIGHT:
			animated_sprite_2d.play("idle_left")
		elif current_facing == FACINGS.DOWN:
			animated_sprite_2d.play("idle_back")
	else:
		if current_facing == FACINGS.UP:
			animated_sprite_2d.play("walking_front")
		elif current_facing == FACINGS.LEFT:
			animated_sprite_2d.play("walking_right")
		elif current_facing == FACINGS.RIGHT:
			animated_sprite_2d.play("walking_left")
		elif current_facing == FACINGS.DOWN:
			animated_sprite_2d.play("walking_back")
	
func _physics_process(delta: float) -> void:
	var direction : Vector2 = get_movement_input()
	update_facing(direction)
	
	if current_state != STATES.TALKING && current_state != STATES.CHANGING_MASK:
		player_interaction_range.look_at(position + direction)
		handle_movement(direction)
		
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func get_movement_input() -> Vector2:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	if current_state != STATES.TALKING && current_state != STATES.CHANGING_MASK:
		current_state = STATES.MOVING if input_dir else STATES.IDLE
		return input_dir
	return Vector2.ZERO

func update_facing(input_direction : Vector2) -> void:
	if input_direction.y != 0:
		current_facing = FACINGS.UP if input_direction.y > 0 else FACINGS.DOWN
	elif input_direction.x != 0:
		current_facing = FACINGS.LEFT if input_direction.x > 0 else FACINGS.RIGHT

func handle_movement(input_direction : Vector2) -> void:
	if input_direction:
		velocity = input_direction * movement_speed
	else:
		velocity = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		restart_loop()
	if event.is_action_pressed("interact"):
		var id := ""
		for object in player_interaction_range.get_overlapping_bodies():
			if object.get_parent().is_in_group("npc"):
				id = object.get_parent().get_dialog_id()
				break
			elif object.get_parent().is_in_group("mask_changer"):
				current_state = STATES.CHANGING_MASK
				gameplay_ui.set_mask_visible(false)
				object.get_parent().open_ui()
				break
		if id != "" && current_state != STATES.TALKING && current_state != STATES.CHANGING_MASK:
			current_state = STATES.TALKING
			dialogue_overlay.start(id)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and current_state == STATES.TALKING:
		dialogue_overlay.continue_dialog()

func _on_dialogue_overlay_dialog_finished() -> void:
	current_state = STATES.IDLE

func _on_game_timer_timeout() -> void:
	pass

func _on_done_editing() -> void:
	current_state = STATES.IDLE
	gameplay_ui.set_mask_visible(true)


func restart_loop():
	restart.emit()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "restart_loop_fade_out":
		dialogue_overlay.abort()
		current_state = STATES.IDLE
