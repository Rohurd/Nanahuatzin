extends Control

var max_ships = 100
var volume_ratio = 1.0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()
	
	var projectResolution = get_viewport().size
	var scene = load("res://Scenes/Triangle.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("player")
	scene_instance.set_position(Vector2(10000, projectResolution.y / 2))
	pass

func _on_screen_resized():
	var projectResolution = get_viewport().size
	find_node("Water").scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var projectResolution = get_viewport().size	
	for node in $"/root/Menu/Ships".get_children() :
		node.position.x += 1
		if node.position.x > projectResolution.x + 50 :
			node.queue_free()
	
	if randf() > 0.97 && $"/root/Menu/Ships".get_child_count() < max_ships :
		var scene = load("res://Scenes/Dummy_Ship.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("ship")
		scene_instance.set_position(Vector2(-30, randi() % int(projectResolution.y + 1)))
		scene_instance.z_index = -1
		
		$"/root/Menu/Ships".add_child(scene_instance)
	pass


func _on_Start_pressed():
	var scene = load("res://Scenes/Level.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Level")
	$"/root".add_child(scene_instance)
	queue_free()
	pass # replace with function body


func _on_Options_pressed():
	$"/root/Menu/Main".hide()
	$"/root/Menu/Options".show()
	pass # replace with function body


func _on_MusicVolumeSlider_value_changed(value):
	$"/root/Menu/Options/MusicVolumeValueLabel".text = str(value)
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), voldb)
	pass # replace with function body
	
func _on_EffectsVolumeSlider_value_changed(value):
	$"/root/Menu/Options/EffectsVolumeValueLabel".text = str(value)
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), voldb)
	pass # replace with function body


func _on_Back_pressed():
	$"/root/Menu/Main".show()
	$"/root/Menu/Options".hide()
	pass # replace with function body

func _on_MusicVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$"/root/Menu/Options/MusicTestSound".play()

func _on_EffectsVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$"/root/Menu/Options/EffectsTestSound".play()
