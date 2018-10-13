extends "res://Scripts/Entity.gd"

var shoot_timer = 0.0

func _ready():
	max_health = 3
	health = max_health
	add_to_group("tower")

func collision_detected(other):
	pass
	
func _get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest_player_position = Vector2(10000, 10000)
	var min_distance = INF
	var distance = 0
	for enemy in enemies:
		distance = (enemy.position  - position).length()
		if distance < min_distance:
			min_distance = distance
			nearest_player_position = enemy.position
	return nearest_player_position

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
		
	var nearest_enemy_position = _get_nearest_enemy()
	
	if nearest_enemy_position != Vector2(10000, 10000):
		var velocity = (nearest_enemy_position - position).normalized()
		var cannon = $Cannon
		cannon.rotation = calc_rotation(cannon.rotation, velocity, delta)
		shoot_timer += delta
	
	if shoot_timer >= 0.5:
		shoot_timer = 0.0
		
		var scene = load("res://Scenes/Bullet.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("bullet")
		scene_instance.set_position(position + Vector2(40,0).rotated(get_child(2).rotation))
		scene_instance.set_rotation(get_child(2).rotation)
		scene_instance.init(Vector2(10,0).rotated(get_child(2).rotation), "tower")
		scene_instance.scale = Vector2(1,1)
		$"/root/Level".add_child(scene_instance)
		
		$"/root/Level".play_small_sound(0)
	pass
