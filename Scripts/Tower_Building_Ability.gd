extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func build_tower():
	var scene = load("res://Scenes/Tower.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("tower")
	var player = get_parent()
	var newPos = Vector2(60,0).rotated(player.rotation) + player.position
	scene_instance.set_position(newPos)
	player.get_parent().add_child(scene_instance)
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_just_pressed("square_build_tower"):
		build_tower()
	pass