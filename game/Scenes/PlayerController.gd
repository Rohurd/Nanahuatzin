extends Node

var controlls = ["_up", "_down", "_right", "_left", "_action", "_abort"]
var index = "1"

func get_inputs(controlled):
	if Input.is_action_pressed(str(index) + "_up"):
		controlled.up()
	if Input.is_action_pressed(str(index) + "_down"):
		controlled.down()
	if Input.is_action_pressed(str(index) + "_right"):
		controlled.right()
	if Input.is_action_pressed(str(index) + "_left"):
		controlled.left()
	if Input.is_action_just_pressed(str(index) + "_action"):
		controlled.action()
	if Input.is_action_just_pressed(str(index) + "_abort"):
		controlled.abort()

	
