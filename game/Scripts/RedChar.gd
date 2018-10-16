extends "res://Scripts/Entity.gd"

const controllable = preload("res://Scripts/controllable.gd")

var velocity = Vector2()
var controller = null
var candidate = []

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
	if len(candidate) == 1 and candidate[0] is controllable:
		candidate[0].get_control(self)

func get_velocity():
	velocity = Vector2()
	if controller != null:
		controller.get_inputs(self)
	return velocity

func _physics_process(delta):
	var velocity = get_velocity()
	self.rotation = calc_rotation(self.rotation, velocity, delta)
	move(velocity,delta)