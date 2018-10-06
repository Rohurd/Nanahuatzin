extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var max_enemies = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var timeNode = $"/root/Level/HUD/Time"
	if !timeNode.pause && get_child_count() < max_enemies:
		var scene = load("res://Scenes/Enemy1.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("enemy")
		var x = 0
		var y = 0
		
		var projectResolution=get_viewport().size
		if randf() > 0.5:
			x = 0 if (randf() > 0.5) else projectResolution.x
			y = randi() % int(projectResolution.y + 1)
		else:
			y = 0 if (randf() > 0.5) else projectResolution.y
			x = randi() % int(projectResolution.x + 1)
		
		scene_instance.set_position(Vector2(x,y))
		add_child(scene_instance)
	pass
