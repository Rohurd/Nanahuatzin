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
	if (health == 0) :
		if (is_in_group("enemy")):
			destroy()
		else:
			health -= 1
			$"/root/Level".players_alive -= 1
		return
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
	if $"/root/Level".players_alive > 0:
		position.x = clamp(position.x, radius, projectResolution.x - radius)
		position.y = clamp(position.y, radius, projectResolution.y - radius)
	else :
		if position.x < -radius || position.y < -radius || position.x > projectResolution.x + radius || position.y > projectResolution.y + radius:
			destroy()

func setHealth(value):
	if value >= 0 && value != health:
		health = value
		emit_signal("health_changed", self)

func _get_nearest_player(players):
	var nearest_player_position = Vector2(10000, 10000)
	var min_distance = INF
	var distance = 0
	for player in players:
		if player.health <= 0:
			continue
		distance = (player.position  - position).length()
		if distance < min_distance:
			min_distance = distance
			nearest_player_position = player.position
	if $"/root/Level".players_alive == 0:
		var projectResolution=get_viewport().size
		nearest_player_position = Vector2(25,0).rotated(rotation + PI) + position
	return nearest_player_position

func destroy():
	if is_in_group("enemy") && ($"/root/Level/Spawn_Enemies").enemies_on_screen > 0:
		($"/root/Level/Spawn_Enemies").enemies_on_screen -= 1
	queue_free()

