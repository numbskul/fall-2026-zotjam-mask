extends Camera2D

@export var target: Node2D #player
@export var follow_smoothing: float = 8.0

var locked := false
var lock_position: Vector2
var current_room: Area2D = null

func _process(delta):
	if locked:
		global_position = lock_position
	elif target:
		global_position = global_position.lerp(target.global_position, follow_smoothing * delta)

func enter_room(room: Area2D, pos: Vector2):
	current_room = room
	locked = true
	lock_position = pos

func exit_room(room: Area2D):
	#unlock if we leave, this has to happen before moving in a new room if there is one
	if current_room == room:
		current_room = null
		#locked = false
