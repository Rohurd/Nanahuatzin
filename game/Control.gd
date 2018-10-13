extends "res://Scripts/controllable.gd"

var value = 0.0
	
func left():
	value -= 1
	
func right():
	value += 1

func _process(delta):
	._process(delta)
	value -= value/20.0
	rotation = (value / 10.0) * PI
	
func body_entered(body):
	body.candidate.append(self)
	
func body_left(body):
	body.candidate.erase(self)