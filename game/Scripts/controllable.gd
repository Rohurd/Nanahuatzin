extends Area2D

var controller = null
var avatar = null
var control_position = null
var button = null

var one_action = false

var button_time = 0
var button_pos = Vector2()

func _ready():
	self.connect("body_entered", self, "body_entered")
	self.connect("body_exited", self, "body_exited")
	var ctrl_point = find_node("ControlPosition")
	if ctrl_point != null:
		control_position = position + ctrl_point.position
		ctrl_point.queue_free()
	button = $Button
	if button != null:
		button_pos = button.position
		
func get_control(from):
	if one_action:
		action()
	else:
		button.hide()
		avatar = from
		if control_position != null:
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
	else:
		if button != null:
			button_time = (delta + button_time)
			if button_time > 2.0*PI:
				button_time -= 2.0*PI
			button.position.y = button_pos.y+ sin(button_time)*10
		
func body_entered(body):
	if "candidate" in body:
		if controller == null:
			button.show()
		body.candidate.append(self)
	
func body_exited(body):
	if "candidate" in body:
		body.candidate.erase(self)
		if len(body.candidate) == 0:
			button.hide()
	
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