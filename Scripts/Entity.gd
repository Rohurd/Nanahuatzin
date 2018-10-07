extends KinematicBody2D

export var speed = 250
export var radius = 15
var target_rotation = 0
var default_direction = Vector2(1, 0)
export var rotation_speed = 2* PI
export var max_health = 1
export var health = 1 setget setHealth

var rot_epsilon = 1.5* rotation_speed/60

func rotate(velocity, delta, to_rotate):
	if to_rotate.rotation > PI:
		to_rotate.rotation -= 2*PI
	if to_rotate.rotation < -PI:
		to_rotate.rotation += 2*PI
	if (health == 0) :
		if is_in_group("enemy") || is_in_group("tower"):
			if is_in_group("tower") :
				$"/root/Level/Sounds/TowerDestruction".play()
			destroy()
		elif is_in_group("player"):
			health -= 1
			$"/root/Level".players_alive -= 1
		return
	var projectResolution=get_viewport().size
	if velocity.length() > 0:
		velocity = velocity.normalized()
		target_rotation = -velocity.angle_to(default_direction)
	else:
		target_rotation = to_rotate.rotation
	var drot = target_rotation - to_rotate.rotation

	if abs(drot) < rot_epsilon:
		to_rotate.rotation = target_rotation
	elif drot < -PI:
		to_rotate.rotation += rotation_speed*delta
	elif drot < 0:
		to_rotate.rotation -= rotation_speed*delta
	elif drot < PI:
		to_rotate.rotation += rotation_speed*delta
	else:
		to_rotate.rotation -= rotation_speed*delta

func move(velocity,delta):
	var projectResolution=get_viewport().size
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	if $"/root/Level".players_alive > 0:
		position.x = clamp(position.x, -radius, projectResolution.x + radius)
		position.y = clamp(position.y, -radius, projectResolution.y + radius)
	else :
		if position.x < -radius || position.y < -radius || position.x > projectResolution.x + radius || position.y > projectResolution.y + radius:
			destroy()

func setHealth(value):
	if value >= 0 && value != health:
		health = value
		if is_in_group("player"):
			emit_signal("health_changed", self)

func _get_nearest_player():
	
	var to_hit = get_tree().get_nodes_in_group("tower")
	var players = get_tree().get_nodes_in_group("player")
	to_hit.append(players[0])
	to_hit.append(players[1])
	
	var nearest_player_position = Vector2(INF, INF)
	var min_distance = INF
	var distance = 0
	for entity in to_hit:
		if entity.health <= 0:
			continue
		distance = (entity.position  - position).length()
		if distance < min_distance:
			min_distance = distance
			nearest_player_position = entity.position
	if $"/root/Level".players_alive == 0 || $"/root/Level/HUD/Time".pause:
		var projectResolution=get_viewport().size
		nearest_player_position = (-position + projectResolution/2).rotated(PI) + position
	return nearest_player_position

func destroy():
	if is_in_group("enemy") && ($"/root/Level/Spawn_Enemies").enemies_on_screen > 0:
		($"/root/Level/Spawn_Enemies").enemies_on_screen -= 1
	queue_free()
