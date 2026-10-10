class_name MaskResource extends Resource

enum EMBLEM_SHAPE {SQUARE, CIRCLE, TRIANGLE, STAR}
enum EMBLEM_COLOR {BLACK, RED, BLUE, GREEN}
enum EYE_SHAPE {LONG, SHORT, DOT, TRIANGLE}
enum EYE_COLOR {BLACK, RED, BLUE, GREEN}
enum MOUTH_SHAPE {NEUTRAL, SMILE, FROWN, DOT}
enum MOUTH_COLOR {BLACK, RED, BLUE, GREEN}

@export var emblem_shape : EMBLEM_SHAPE
@export var emblem_color : EMBLEM_COLOR
@export var eye_shape : EYE_SHAPE
@export var eye_color : EYE_COLOR
@export var mouth_shape : MOUTH_SHAPE
@export var mouth_color : MOUTH_COLOR

var mask_dict = {
	"emblem_shape" : emblem_shape,
	"emblem_color" : emblem_color,
	"eye_shape" : eye_shape,
	"eye_color" : eye_color,
	"mouth_shape" : mouth_shape,
	"mouth_color" : mouth_color,
}

func update_mask_dict():
	mask_dict = {
		"emblem_shape" : emblem_shape,
		"emblem_color" : emblem_color,
		"eye_shape" : eye_shape,
		"eye_color" : eye_color,
		"mouth_shape" : mouth_shape,
		"mouth_color" : mouth_color,
	}
