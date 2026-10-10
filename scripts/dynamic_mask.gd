extends AnimatedSprite2D

@onready var emblem: AnimatedSprite2D = $Emblem
@onready var eyes: AnimatedSprite2D = $Eyes
@onready var mouth: AnimatedSprite2D = $Mouth

var color_dict = {
	0 : Color.BLACK,
	1 : Color.RED,
	2 : Color.BLUE,
	3 : Color.GREEN
}

func set_mask(resource : MaskResource):
	emblem.set_frame_and_progress(resource.emblem_shape, 0.0)
	emblem.modulate = color_dict[resource.emblem_color]
	eyes.set_frame_and_progress(resource.eye_shape, 0.0)
	eyes.modulate = color_dict[resource.eye_color]
	mouth.set_frame_and_progress(resource.mouth_shape, 0.0)
	mouth.modulate = color_dict[resource.mouth_color]
	
