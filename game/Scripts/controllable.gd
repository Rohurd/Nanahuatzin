extends Area2D

var controller = null
var avatar = null
var control_position = null

func _ready():
	self.connect("body_entered", self, "body_entered")
	self.connect("body_exited", self, "body_exited")
	var ctrl_point = $ControlPosition
	if ctrl_point != null:
		control_position = position + ctrl_point.position
		ctrl_point.queue_free()
		
func get_control(from):
	avatar = from
	if control_position != null:
		print("moving controller")
		avatar.position = control_position
		avatar.look_at(position)
	controller = avatar.controller
	avatar.controller = null
	
func give_up_control():
	avatar.controller = controller
	controller = null
	
func _process(delta):
	if controller != null:
		controller.get_inputs(self)
		
func body_entered(body):
	body.candidate.append(self)
	
func body_exited(body):
	body.candidate.erase(self)
	
func left():
	pass
	
func right():
	pass
	
func up():
	pass
	
func down():
	pass
	
func action():
	pass
	
func abort():
	give_up_control()