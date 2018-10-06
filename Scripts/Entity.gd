extends KinematicBody2D

export var speed = 250
export var radius = 15
var target_rotation = 0
var default_direction = Vector2(1, 0)
export var rotation_speed = 2* PI
export var max_health = 1
export var health = 1 setget setHealth

var rot_epsilon = 1.5* rotation_speed/60

func move_rotate(velocity,delta):
	var projectResolution=get_viewport().size
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

func setHealth(value):
	if value >= 0 && value != health:
		health = value
		emit_signal("health_changed", self)

func _get_nearest_player(players):
	var nearest_player = players[0]
	var min_distance = INF
	var distance = 0
	for player in players:
		distance = (player.position  - position).length()
		if distance < min_distance:
			min_distance = distance
			nearest_player = player
	return nearest_player

func destroy():
	queue_free()

