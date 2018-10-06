extends "res://Scripts/Entity.gd"

var players
var target
var target_pos = Vector2(0,0)

func _ready():
	add_to_group("enemy")
	speed = 100
	health = 3
	max_health = 3
	players = get_tree().get_nodes_in_group("player")
	
func _physics_process(delta):
	target_pos = _get_nearest_player(players)
	var velocity = (target_pos - position).normalized()
	move_rotate(velocity,delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var player = collision.collider
		if player.is_in_group("player") && player.health > 0:
			player.setHealth(player.health-1)
			destroy()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
