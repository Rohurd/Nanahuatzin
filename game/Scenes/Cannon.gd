extends "res://Scripts/controllable.gd"

var ship_origin = Vector2()
var shoot_origin = Vector2()
var shoot_direction = Vector2()
var size = 1

export var cooldown = 1
var current_cooldown = 0

func _ready():
	$Line2D.hide()
	one_action = true
	shoot_origin = $Line2D.get_point_position(1).rotated(-rotation) - ship_origin
	shoot_direction = shoot_origin - ($Line2D.get_point_position(0).rotated(-rotation) - ship_origin)
	shoot_direction = shoot_direction.normalized()

func action():
	if current_cooldown <= 0:
		LevelStatus.ship.shooot(shoot_origin / size, shoot_direction)
		current_cooldown = cooldown
		$ProgressBar.show()
	
func _process(delta):
	current_cooldown -= delta
	$ProgressBar.value = 100 * current_cooldown / cooldown 
	if current_cooldown < 0:
		$ProgressBar.hide()
		current_cooldown = 0
	
	