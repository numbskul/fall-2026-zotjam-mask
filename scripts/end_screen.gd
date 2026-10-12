extends Control

@onready var node: Node = $Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node.start_dialog("lose_bomb")

func _on_timer_timeout() -> void:
	node.dialog_acknowledge()


func _on_node_dialog_finished(sheet_name: Variant, sequence_id: Variant) -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
