extends Node
const DEFAULT_MASK = preload("uid://bcxnxlgtsqgvc")

var mask_dict = {
	"emblem_shape" : DEFAULT_MASK.emblem_shape,
	"emblem_color" : DEFAULT_MASK.emblem_color,
	"eye_shape" : DEFAULT_MASK.eye_shape,
	"eye_color" : DEFAULT_MASK.eye_color,
	"mouth_shape" : DEFAULT_MASK.mouth_shape,
	"mouth_color" : DEFAULT_MASK.mouth_color
}

func update_mask_dict(new_mask_dict : MaskResource):
	mask_dict = new_mask_dict

signal done_editing_mask
