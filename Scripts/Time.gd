extends TextureProgress

var timer = 0.0
var level_time = 20
export var round_count = 0
export var pause = true

func _ready():
	max_value = 7 if pause else level_time
	value = 0 if pause else max_value
	set_process(true)

func _process(delta):
	timer += delta
	if timer >= 1.0 && $"/root/Level".players_alive > 0:
		# One second has elapsed
		timer = 0.0
		if pause:
			value += 1
		else:
			value -= 1
			
	if !pause && value <= 0:
		pause = !pause
		level_time = int(level_time + 5)
		var enemy_node = $"/root/Level/Spawn_Enemies"
		enemy_node.max_enemies = int(enemy_node.max_enemies + 10)
		round_count += 1
		max_value = 7 if pause else level_time
		value = 0
	elif pause && value >= max_value:
		pause = !pause
		max_value = 7 if pause else level_time
		value = max_value