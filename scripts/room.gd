extends Area2D

@export var camera_controller: Camera2D
# position of locking camera, usually center of room
@export var lock_point: Node2D

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		var pos = lock_point.global_position if lock_point else global_position
		camera_controller.enter_room(self, pos)

func _on_body_exited(body):
	if body.is_in_group("player"):
		camera_controller.exit_room(self)
