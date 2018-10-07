extends "res://Scripts/Entity.gd"

var target
var target_pos = Vector2(0,0)

func _ready():
	add_to_group("enemy")
	speed = 100
	
func _physics_process(delta):
	target_pos = _get_nearest_player()
	var velocity = (target_pos - position).normalized()
	rotate(velocity, delta, self)
	move(velocity,delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var player = collision.collider
		if (player.is_in_group("player") || player.is_in_group("tower")) && player.health > 0:
			player.setHealth(player.health-1)
			$"/root/Level/ExpGen".gen_exp_big(global_position)
			if player.name == "Triangle" :
				$"/root/Level/HUD/TrianglePoints".text = str(int($"/root/Level/HUD/TrianglePoints".text) + 1)
			elif player.name == "Square":
				$"/root/Level/HUD/SquarePoints".text = str(int($"/root/Level/HUD/SquarePoints".text) + 1)
			destroy()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
