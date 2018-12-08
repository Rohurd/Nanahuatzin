extends "res://Scripts/Entity.gd"

var target_pos = Vector2(0,0)
var player_pos = Vector2(0,0)

var path = []
var traveling = false

var temp_i_remove_when_commit = 0

func _ready():
	add_to_group("enemy")
	speed = 100
	radius = 50
	
	
func get_path_to(target):
	var path = $"/root/Level/world/Navigation2D".get_simple_path(position, target)
	return path

func _physics_process(delta):
	temp_i_remove_when_commit += 1
	temp_i_remove_when_commit %= 60
	if temp_i_remove_when_commit != 0:
		return
	if not traveling:
		player_pos = $"/root/Level/world/Triangle".position
		path = get_path_to(player_pos)
		traveling = true
	target_pos = self.position
	if len(path) > 0:
		target_pos = path[1]
	if (target_pos - position).length() < 20:
		traveling = false
	if (player_pos - position).length() < 300:
		traveling = false
	var velocity = (target_pos - position).normalized()
	self.rotation = calc_rotation(self.rotation, velocity, delta)
	move(velocity,delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var player = collision.collider
		if (player.is_in_group("player") || player.is_in_group("tower")) && player.health > 0:
			player.setHealth(player.health-1)
			$"/root/Level/ExpGen".gen_exp_big(global_position)
			$"/root/Level/HUD/Points".text = str(int($"/root/Level/HUD/Points".text) + 1)
			setHealth(0)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
