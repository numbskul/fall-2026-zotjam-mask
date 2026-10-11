extends AnimatedSprite2D

@onready var emblem: AnimatedSprite2D = $Emblem
@onready var eyes: AnimatedSprite2D = $Eyes
@onready var mouth: AnimatedSprite2D = $Mouth

var color_dict = {
	0 : Color(14.0/255, 26.0/255, 21.0/255),
	1 : Color(145/255.0, 57/255.0, 48/255.0),
	2 : Color(51/255.0, 85/255.0, 82/255.0),
	3 : Color(90/255.0, 121/255.0, 73/255.0)
}


func set_mask(resource : Dictionary):
	emblem.set_frame_and_progress(resource["emblem_shape"], 0.0)
	emblem.modulate = color_dict[resource["emblem_color"]]
	eyes.set_frame_and_progress(resource["eye_shape"], 0.0)
	eyes.modulate = color_dict[resource["eye_color"]]
	mouth.set_frame_and_progress(resource["mouth_shape"], 0.0)
	mouth.modulate = color_dict[resource["mouth_color"]]
	
