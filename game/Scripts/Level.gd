extends Node

export var players_alive = 2
export var used_sound_player = 0

var remapping = false
var remapping_controller = null
var characters = []
var controlls = ["1_up", "1_down", "1_left", "1_right", "1_action", "1_abort"]
var remapping_i = 0

var last_axis = null
var last_axis_value = null

func new_player():
	var Controller = load("res://Scenes/PlayerController.tscn")
	var controller = Controller.instance()
	remapping_controller = controller
	remapping = true
	$Players.add_child(controller)
	controller.index = 1
	LevelStatus.player.controller = controller
	
	$HUD/MapLabels.get_child(0).show()

func _input(e):
	if remapping:
		var go_on = false
		if e is InputEventKey:
			if not e.echo and e.pressed:
				go_on = true
		if e is InputEventJoypadButton:
			if e.pressed:
				go_on = true
		if e is InputEventJoypadMotion:
			if abs(e.axis_value) > 0.5 and (e.axis != last_axis or e.axis_value / abs(e.axis_value) != last_axis_value):
				go_on = true
				last_axis = e.axis
				last_axis_value = e.axis_value / abs(e.axis_value)
		
		if go_on:
			print(e)
			var action = controlls[remapping_i]
			var mapped = InputMap.get_action_list(action)
			for mapped_input in mapped:
				InputMap.action_erase_event(action, mapped_input)
			InputMap.action_add_event(action, e)
			$HUD/MapLabels.get_child(remapping_i).hide()
			remapping_i += 1
			if remapping_i >= len(controlls):
				remapping = false
				remapping_i = 0
				remapping_controller = null
			else:
				$HUD/MapLabels.get_child(remapping_i).show()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()
	LevelStatus.world = $World
	
func _process(delta):
	if Input.is_action_just_pressed("new_player"):
		print("new player")
		new_player()

func init(difficulty):
	match difficulty:
		"Easy" : LevelStatus.max_enemies = 5
		"Medium" : LevelStatus.max_enemies = 10
		"Hard" : LevelStatus.max_enemies = 20

func _on_screen_resized():
	var projectResolution = get_viewport().size
	find_node("Water").scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)
	
func play_small_sound(db):
	$Sounds/SmallShootCache.get_child(used_sound_player).volume_db = db
	$Sounds/SmallShootCache.get_child(used_sound_player).play()
	used_sound_player += 1
	if used_sound_player > 4:
		used_sound_player = 0
