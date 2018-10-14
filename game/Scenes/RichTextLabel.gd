extends RichTextLabel

var o_pos = Vector2()
var t = 0

func _ready():
	o_pos = rect_position
	
func _process(delta):
	t += delta
	rect_position.y = o_pos.y + sin(t) * 10
	
