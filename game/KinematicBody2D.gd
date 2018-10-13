extends "res://Scripts/Entity.gd"

var velocity = Vector2()
var controller = null

func _ready():
	LevelStatus.player = self
	rotation_speed = 6 * PI
	
func right():
	velocity.x += 1

func left():
	velocity.x -= 1
	
func down():
	velocity.y += 1
	
func up():
	velocity.y -= 1
	
func abort():
	pass
	
func action():
	pass

func get_velocity():
	velocity = Vector2()
	if controller != null:
		controller.get_inputs(self)
	return velocity

func _physics_process(delta):
	var velocity = get_velocity()
	self.rotation = calc_rotation(self.rotation, velocity, delta)
	move(velocity,delta)
