extends Node2D

export var players_alive = 2
export var used_sound_player = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()
	pass

func _on_screen_resized():
	var projectResolution = get_viewport().size
	find_node("Water").scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)
	
func play_small_sound(db):
	$"/root/Level/Sounds/SmallShootCache".get_child(used_sound_player).volume_db = db
	$"/root/Level/Sounds/SmallShootCache".get_child(used_sound_player).play()
	used_sound_player += 1
	if used_sound_player > 4:
		used_sound_player = 0
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
