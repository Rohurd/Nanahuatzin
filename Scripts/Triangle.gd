extends KinematicBody2D

export var speed = 250
export var radius = 15
var target_rotation = 0
var default_direction = Vector2(1, 0)
export var rotation_speed = 2* PI

var rot_epsilon = 1.5* rotation_speed/60

func _ready():
	add_to_group("players")

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	var projectResolution=get_viewport().size
	if Input.is_action_pressed("triangle_right"):
		velocity.x += 1
	if Input.is_action_pressed("triangle_left"):
		velocity.x -= 1
	if Input.is_action_pressed("triangle_down"):
		velocity.y += 1
	if Input.is_action_pressed("triangle_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		target_rotation = -velocity.angle_to(default_direction)
	else:
		target_rotation = rotation
	var drot = target_rotation - rotation

	if abs(drot) < rot_epsilon:
		rotation = target_rotation
	elif drot < -PI:
		rotation += rotation_speed*delta
	elif drot < 0:
		rotation -= rotation_speed*delta
	elif drot < PI:
		rotation += rotation_speed*delta
	else:
		rotation -= rotation_speed*delta
	move_and_slide(velocity)
	position.x = clamp(position.x, radius, projectResolution.x - radius)
	position.y = clamp(position.y, radius, projectResolution.y - radius)
