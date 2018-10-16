extends Node2D

const Character = preload("res://Scenes/RedChar.tscn")

var controlled_ship = null

func _ready():
	LevelStatus.ship_controller = self
	print(LevelStatus.players)
	var i = 1
	for player in LevelStatus.players:
		if player != null:
			var character = Character.instance()
			character.position = self.find_node("Spawnpoint"+str(i)).position
			character.controller = player
			$players.add_child(character)

func _process(delta):
	if controlled_ship != null:
		controlled_ship.helm($Control.value*delta)
		controlled_ship.vel = $Control.speed / $Control.speed_max