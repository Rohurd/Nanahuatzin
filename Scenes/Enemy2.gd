extends "res://Scripts/Entity.gd"

var players
var target
var target_pos = Vector2(0,0)
var shoot_timer = 0.0

func _ready():
	add_to_group("enemy")
	speed = 150
	players = get_tree().get_nodes_in_group("player")
	
func _physics_process(delta):
	target = _get_nearest_player(players)
	target_pos = target.position
	var velocity = (target_pos - position - Vector2(100,0).rotated(rotation)).normalized()
	move_rotate(velocity,delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var player = collision.collider
		if player.is_in_group("player"):
			player.setHealth(player.health-1)
			queue_free()
	shoot_timer += delta
	if shoot_timer >= 0.5:
		shoot_timer = 0.0
		var scene = load("res://Scenes/Bullet.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("bullet")
		scene_instance.set_position(position + Vector2(25,0).rotated(rotation))
		scene_instance.set_rotation(rotation)
		scene_instance.init(Vector2(10,0).rotated(rotation), "enemy")
		get_parent().add_child(scene_instance)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
