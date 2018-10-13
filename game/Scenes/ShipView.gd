extends Node2D

var controlled_ship = null

func _ready():
	LevelStatus.ship_controller = self

func _process(delta):
	if controlled_ship != null:
		controlled_ship.helm($Control.value*delta)