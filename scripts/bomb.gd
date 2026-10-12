extends Node2D

class_name Bomb

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var code_area: Label = $BombDefuse/Panel/VBoxContainer/HBoxContainer/Label
@onready var defuse_ui: CanvasLayer = $BombDefuse

signal bomb_defused

var defused: bool = false

func _ready() -> void:
	add_to_group("bomb")

func open_ui() -> void:
	defuse_ui.visible = true

func _unhandled_input(event: InputEvent) -> void:	
	if (defused):
		return
	if defuse_ui.visible and event is InputEventKey and event.pressed:
		var key = event.as_text()
		code_area.text += key
		if (code_area.text.length() >= 3):
			if (code_area.text == "926"):
				code_area.text = "DEFUSED"
				defused = true
				bomb_defused.emit()
			else:
				defuse_ui.visible = false
				code_area.text = ""
