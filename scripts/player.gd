extends CharacterBody2D

@onready var gameplay_ui: Control = $"Gameplay UI"
@onready var dialogue_overlay: Control = $DialogueOverlay
@onready var player_interaction_range: Area2D = $PlayerInteractionRange
@export var movement_speed = 96.0

@export var timer : Timer

enum FACINGS {UP, DOWN, LEFT, RIGHT}
enum STATES {IDLE, MOVING, TALKING}
var current_facing := FACINGS.DOWN
var current_state := STATES.IDLE

@onready var dynamic_mask: AnimatedSprite2D = $DynamicMask

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	gameplay_ui.set_mask_visible(current_state != STATES.TALKING)
	gameplay_ui.update_timer_label(timer.time_left)
	gameplay_ui.update_mask(PlayerMaskData.mask_dict)
	
func _physics_process(delta: float) -> void:
	var direction : Vector2 = get_movement_input()
	update_facing(direction)
	
	if current_state != STATES.TALKING:
		player_interaction_range.look_at(position + direction)
		handle_movement(direction)
		
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func get_movement_input() -> Vector2:
	var input_dir := Input.get_vector("left", "right", "up", "down")
	if current_state != STATES.TALKING:
		current_state = STATES.MOVING if input_dir else STATES.MOVING
	return input_dir 

func update_facing(input_direction : Vector2) -> void:
	if input_direction.y != 0:
		current_facing = FACINGS.UP if input_direction.y > 0 else FACINGS.DOWN
	elif input_direction.x != 0:
		current_facing = FACINGS.LEFT if input_direction.y > 0 else FACINGS.RIGHT

func handle_movement(input_direction : Vector2) -> void:
	if input_direction:
		velocity = input_direction * movement_speed
	else:
		velocity = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var id := ""
		for object in player_interaction_range.get_overlapping_bodies():
			if object.get_parent().is_in_group("npc"):
				id = object.get_parent().get_dialog_id()
				break
			elif object.get_parent().is_in_group("mask_changer"):
				pass
		if id != "":
			current_state = STATES.TALKING
			dialogue_overlay.start(id)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and current_state == STATES.TALKING:
		dialogue_overlay.continue_dialog()

func _on_dialogue_overlay_dialog_finished() -> void:
	current_state = STATES.IDLE

func _on_game_timer_timeout() -> void:
	pass
