extends "res://Scripts/Movement_Rotation.gd"

var players
var target
var target_pos = Vector2(0,0)

func _ready():
	speed = 150
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
	move_rotate(velocity,delta)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
