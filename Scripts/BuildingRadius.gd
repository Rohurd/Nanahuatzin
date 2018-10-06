extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var possible_buildings = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func area_entered(other):
	if other.is_in_group("SoonToBeTower"):
		possible_buildings.append(other)
		possible_buildings[0].mark()
		
func area_left(other):
	if other.is_in_group("SoonToBeTower"):
		possible_buildings.erase(other)
		other.unmark()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
