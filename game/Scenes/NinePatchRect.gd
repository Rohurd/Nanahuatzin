extends NinePatchRect

func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()
	show()

func _on_screen_resized():
	rect_size = get_viewport().size
