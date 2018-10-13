extends KinematicBody2D

export var speed = 250
var target_rotation = 0
var default_direction = Vector2(1, 0)
export var rotation_speed = 2* PI
export var max_health = 1
export var health = 1 setget setHealth
signal death()
var radius = 15

var rot_epsilon = 1.5* rotation_speed/60

func _process(delta):
	if (health == 0) :
		if is_in_group("enemy") || is_in_group("tower"):
			if is_in_group("tower") :
				$"/root/Level/Sounds/TowerDestruction".play()
			destroy()
		elif is_in_group("player"):
			health -= 1
			$"/root/Level".players_alive -= 1
			if $"/root/Level".players_alive == 0:
				$"/root/Level/Sounds/GameOver".play()
		return

# Calculate rotation of the next frame when moving with _velocity_
func calc_rotation(current_rotation, velocity, delta):
	var target_rotation = current_rotation
	if current_rotation > PI:
		current_rotation -= 2*PI
	if current_rotation < -PI:
		current_rotation += 2*PI
	if velocity.length() > 0:
		velocity = velocity.normalized()
		target_rotation = -velocity.angle_to(default_direction)

	var drot = target_rotation - current_rotation

	if abs(drot) < rot_epsilon:
		current_rotation = target_rotation
	elif drot < -PI:
		current_rotation += rotation_speed*delta
	elif drot < 0:
		current_rotation -= rotation_speed*delta
	elif drot < PI:
		current_rotation += rotation_speed*delta
	else:
		current_rotation -= rotation_speed*delta
	return current_rotation

func move(velocity,delta):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide(velocity)

func setHealth(value):
	if value >= 0 && value != health:
		health = value
		if health == 0:
			emit_signal("death", self)
			print("death")
			destroy()
		if is_in_group("player"):
			emit_signal("health_changed", self)

func _get_nearest_player():
	
	var to_hit = get_tree().get_nodes_in_group("tower")
	var players = get_tree().get_nodes_in_group("player")
	for player in players :
		to_hit.append(player)
	
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
	if $"/root/Level".players_alive == 0 || LevelStatus.paused:
		var projectResolution=get_viewport().size
		nearest_player_position = (-position + projectResolution/2).rotated(PI) + position
	return nearest_player_position

func destroy():
	queue_free()
