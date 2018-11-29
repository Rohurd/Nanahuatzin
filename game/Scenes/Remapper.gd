extends Node

var remapping = null
var remapping_controller = null
var characters = []
var controlls = ["_up", "_down", "_left", "_right", "_action", "_abort"]
var remapping_i = 0

var last_axis = null
var last_axis_value = null

func _ready():
	var buttons = []
	for i in range(0,len(LevelStatus.players)):
		var button = $BackButton.duplicate()
		button.text = "Player " + str(i+1)
		button.rect_position = Vector2(20 + (i % 3) * 130, 20 + (i/3) * 40)
		button.show()
		button.connect("pressed", self, "remap", [i])
		add_child(button)
		buttons.append(button)
	pass
	
	$BackButton.connect("pressed", self, "back_button_pressed")

func remap(i):
	remapping = i
	remapping_i = 0
	$MapLabels.get_child(0).show()
	

func new_player():
	var Controller = load("res://Scenes/PlayerController.tscn")
	var controller = Controller.instance()
	remapping_controller = controller
	remapping = true
	LevelStatus.add_child(controller)
	LevelStatus.players.append(controller)
	controller.index = 1
	LevelStatus.player.controller = controller
	
	$MapLabels.get_child(0).show()

func _input(e):
	if remapping != null:
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
			var action = str(remapping) + controlls[remapping_i]
			if !InputMap.has_action(action):
				InputMap.add_action(action)
			var mapped = InputMap.get_action_list(action)
			for mapped_input in mapped:
				InputMap.action_erase_event(action, mapped_input)
			InputMap.action_add_event(action, e)
			$MapLabels.get_child(remapping_i).hide()
			remapping_i += 1
			if remapping_i >= len(controlls):
				remapping = false
				remapping_i = 0
				remapping_controller = null
			else:
				$MapLabels.get_child(remapping_i).show()

func back_button_pressed():
	queue_free()