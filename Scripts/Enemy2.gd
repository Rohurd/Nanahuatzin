extends "res://Scripts/Entity.gd"

var target_pos = Vector2(0,0)
var shoot_timer = 0.0
var shoot_delay = randf()

func _ready():
	add_to_group("enemy")
	speed = 100
	radius = 50
	
func _physics_process(delta):
	target_pos = _get_nearest_player()
	var velocity = (target_pos - position - Vector2(150,0).rotated(rotation)).normalized()
	rotate(velocity, delta, self)
	move(velocity,delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var player = collision.collider
		if (player.is_in_group("player") || player.is_in_group("tower")) && player.health > 0:
			player.setHealth(player.health-1)
			$"/root/Level/ExpGen".gen_exp_big(global_position)
			$"/root/Level/HUD/Points".text = str(int($"/root/Level/HUD/Points".text) + 1)
			destroy()
	shoot_timer += delta
	if !$"/root/Level/HUD/Time".pause && $"/root/Level".players_alive > 0 && shoot_timer >= 0.5 + shoot_delay :
		shoot_delay = randf()
		shoot_timer = 0.0
		var scene = load("res://Scenes/Bullet.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("bullet")
		scene_instance.set_position(position + Vector2(40,0).rotated(rotation))
		scene_instance.set_rotation(rotation)
		scene_instance.init(Vector2(10,0).rotated(rotation), "enemy")
		scene_instance.scale = Vector2(1,1)
		get_parent().add_child(scene_instance)
		
		$"/root/Level".play_small_sound(-5)
