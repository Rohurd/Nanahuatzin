extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var max_enemies = 7
export var enemies_on_screen = 0
var time = 5.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	time += delta
	if time >= 5.0 :
		while !($"/root/Level/HUD/Time").pause && enemies_on_screen < max_enemies && $"/root/Level".players_alive > 0:
			var rng = randf()
			var allowed_enemies = 2
			if rng < 0.3 : 
				allowed_enemies = 3
			elif rng < 0.45 && $"/root/Level/HUD/Time".round_count > 3 :
				allowed_enemies = 2
			var scene = load("res://Scenes/Enemy" + str(allowed_enemies) + ".tscn")
			var scene_instance = scene.instance()
			scene_instance.set_name("enemy")
			var x = -30
			var y = -30
			
			var projectResolution = get_viewport().size
			if randf() > 0.5:
				x = -30 if (randf() > 0.5) else projectResolution.x + 30
				y = randi() % int(projectResolution.y + 1)
			else:
				y = -30 if (randf() > 0.5) else projectResolution.y + 30
				x = randi() % int(projectResolution.x + 1)
			
			scene_instance.set_position(Vector2(x,y))
			add_child(scene_instance)
			enemies_on_screen += 1
		time = 0.0
	pass
