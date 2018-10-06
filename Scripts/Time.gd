extends TextureProgress

var timer = 0.0
export var pause = false

func _ready():
	max_value = 20 if pause else 300
	set_process(true)

func _process(delta):
	timer += delta
	if timer >= 1.0:
		# One second has elapsed
		timer = 0.0
		value += 1
	if value >= max_value:
		pause = !pause
		max_value = 20 if pause else 300
		value = 0
