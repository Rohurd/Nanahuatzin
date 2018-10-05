extends KinematicBody2D

var players
var target
var target_pos = Vector2(0,0)
export var speed = 100
var target_rotation = 0
var default_direction = Vector2(1, 0)
export var rotation_speed = 2* PI

var rot_epsilon = 1.5* rotation_speed/60

func _ready():
	players = get_tree().get_nodes_in_group("players")

func _get_nearest_player():
	var nearest_player = players[0]
	var min_distance = INF
	var distance = 0
	for player in players:
		distance = (player.position  - position).length()
		if distance < min_distance:
			min_distance = distance
			nearest_player = player
	return nearest_player
	
func _process(delta):
	pass

	
func _physics_process(delta):
	target = _get_nearest_player()
	target_pos = target.position
	var velocity = (target_pos - position).normalized()
	target_rotation = -velocity.angle_to(default_direction)
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
	velocity = velocity * speed
	move_and_slide(velocity)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
