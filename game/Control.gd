extends "res://Scripts/controllable.gd"

var value = 0.0
var speed = 0.0
var speed_max = 100.0
	
func left():
	value -= 1
	
func right():
	value += 1
	
func up():
	speed += 1
	speed = clamp(speed, 0.0, 100.0)
	
func down():
	speed -= 1
	speed = clamp(speed, 0.0, 100.0)

func _process(delta):
	._process(delta)
	value -= value/20.0
	$Sprite.rotation = (value / 10.0) * PI