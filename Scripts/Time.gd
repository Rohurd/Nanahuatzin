extends TextureProgress

var timer = 0.0
var level_time = 20
export var round_count = 0
export var pause = false

func _ready():
	max_value = 20 if pause else level_time
	value = max_value
	set_process(true)

func _process(delta):
	timer += delta
	if timer >= 1.0 && $"/root/Level".players_alive > 0:
		# One second has elapsed
		timer = 0.0
		value -= 1
	if value <= 0:
		pause = !pause
		if !pause:
			level_time = int(level_time * 1.5)
			var enemy_node = $"/root/Level/Spawn_Enemies"
			enemy_node.max_enemies = int(enemy_node.max_enemies * 1.5)
			round_count += 1
		max_value = 20 if pause else level_time
		value = max_value
