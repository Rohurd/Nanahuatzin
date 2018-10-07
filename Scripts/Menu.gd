extends Control

var max_ships = 100
var volume_ratio = 1.0
var difficulties = ["Easy","Medium","Hard"]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()

func _on_screen_resized():
	var projectResolution = get_viewport().size
	find_node("Water").scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var projectResolution = get_viewport().size	
	for node in $Ships.get_children() :
		node.position.x += 1
		if node.position.x > projectResolution.x + 50 :
			node.queue_free()
	
	if randf() > 0.97 && $Ships.get_child_count() < max_ships :
		var scene = load("res://Scenes/Dummy_Ship.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("ship")
		scene_instance.set_position(Vector2(-30, randi() % int(projectResolution.y + 1)))
		scene_instance.z_index = -1
		
		$Ships.add_child(scene_instance)


func _on_Start_pressed():
	var scene = load("res://Scenes/Level.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("Level")
	$"/root".add_child(scene_instance)
	scene_instance.init($Options/DifficultyValueLabel.text)
	queue_free()


func _on_Options_pressed():
	$Main.hide()
	$Options.show()


func _on_MusicVolumeSlider_value_changed(value):
	$Options/MusicVolumeValueLabel.text = str(value)
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), voldb)
	
func _on_EffectsVolumeSlider_value_changed(value):
	$Options/EffectsVolumeValueLabel.text = str(value)
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), voldb)


func _on_Back_pressed():
	$Main.show()
	$Options.hide()

func _on_MusicVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$Options/MusicTestSound.play()

func _on_EffectsVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$Options/EffectsTestSound.play()


func _on_Difficulty_value_changed(value):
	$Options/DifficultyValueLabel.text = difficulties[value]
