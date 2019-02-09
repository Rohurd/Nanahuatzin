extends Node

export var players_alive = 2
export var used_sound_player = 0

func _ready(): 
	LevelStatus.world = $world
	LevelStatus.ship_controller.controlled_ship = $world/Triangle

func init(difficulty):
	match difficulty:
		"Easy" : LevelStatus.max_enemies = 5
		"Medium" : LevelStatus.max_enemies = 10
		"Hard" : LevelStatus.max_enemies = 20
	
func play_small_sound():
	$Sounds/SmallShootCache.get_child(used_sound_player).play()
	used_sound_player += 1
	if used_sound_player > 4:
		used_sound_player = 0
