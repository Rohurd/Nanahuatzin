extends Node2D

const Character = preload("res://Scenes/RedChar.tscn")

var controlled_ship = null

func _ready():
	LevelStatus.ship_controller = self
	var i = 1
	for player in LevelStatus.players:
		if player != null:
			var character = Character.instance()
			character.position = self.find_node("Spawnpoint"+str(i)).position
			character.controller = player
			$players.add_child(character)
			
	var tex_size = $BigShip/Sprite.texture.get_size()
	var ship_x = tex_size.x
	var ship_origin = Vector2(tex_size.x/2, tex_size.y/2)
	
	$Cannon.size = ship_x
	$Cannon.ship_origin = ship_origin
	$Cannon2.size = ship_x
	$Cannon2.ship_origin = ship_origin
	$Cannon3.size = ship_x
	$Cannon3.ship_origin = ship_origin
	$Cannon4.size = ship_x
	$Cannon4.ship_origin = ship_origin

func _process(delta):
	if controlled_ship != null:
		controlled_ship.helm($Control.value*delta)
		controlled_ship.vel = $Control.speed / $Control.speed_max