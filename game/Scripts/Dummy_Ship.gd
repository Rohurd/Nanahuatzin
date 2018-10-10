extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var rng = randf()
	if rng < 0.1 :
		self.texture = load("res://Sprites/shooterShip.png")
		self.scale = Vector2(0.25,0.25)
	elif rng < 0.2 :
		self.texture = load("res://Sprites/ship_ranged.png")
		self.rotation_degrees = 270
		self.scale = Vector2(0.45,0.45)
	elif rng < 0.3 :
		self.texture = load("res://Sprites/ship_attack.png")
		self.rotation_degrees = 270
		self.scale = Vector2(0.45,0.45)
	elif rng < 0.5 :
		self.texture = load("res://Sprites/bigShip.png")
		self.scale = Vector2(0.5,0.5)
	else :
		self.texture = load("res://Sprites/SmallShip.png")
		self.scale = Vector2(0.35,0.35)
		self.rotation_degrees = 270
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
