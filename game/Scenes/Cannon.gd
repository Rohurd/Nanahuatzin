extends "res://Scripts/controllable.gd"

func _ready():
	one_action = true

func action():
	LevelStatus.ship.shoot()
	