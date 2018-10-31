extends Node2D

export var rate = 5
export var max_enemies = 5
var enemies_spawned = 0
var spawn_at = 60.0
var val = 0.0

func _ready():
	hide()
	rate = (1+LevelStatus.difficulty) * rate
	max_enemies = (1+LevelStatus.difficulty) * max_enemies
	spawn_at = 1.0 / rate
	
func _process(delta):
	val += delta
	if val >= spawn_at:
		val = 0.0
		spawn()

func enemy_died():
	enemies_spawned -= 1

func spawn():
	if enemies_spawned <= max_enemies:
		var rng = randf()
		var allowed_enemies = 1
		if rng < 0.3 && LevelStatus.enemy_level >= 1:
			allowed_enemies = 3
		elif rng < 0.45 && LevelStatus.enemy_level >= 2:
			allowed_enemies = 2
		var Enemy = load("res://Scenes/Enemy" + str(allowed_enemies) + ".tscn")
		var enemy = Enemy.instance()
		enemy.set_name("enemy")
		enemy.connect("death", self, "enemy_died")
		
		enemy.set_position(position)
		$"/root/Level/world/enemies".add_child(enemy)
		enemies_spawned += 1
	