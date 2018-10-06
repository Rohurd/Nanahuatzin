extends "res://Scripts/Entity.gd"

signal health_changed(player)

var shoot_count = 0

func _ready():
	health = 5
	max_health = 5
	add_to_group("player")
	connect("health_changed", $"/root/Level/HUD/TriangleHealth", "health_changed")
	emit_signal("health_changed", self)

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("triangle_right"):
		velocity.x += 1
	if Input.is_action_pressed("triangle_left"):
		velocity.x -= 1
	if Input.is_action_pressed("triangle_down"):
		velocity.y += 1
	if Input.is_action_pressed("triangle_up"):
		velocity.y -= 1
	if health > -1: 
		rotate(velocity, delta, self)
		move(velocity,delta)
	
	if Input.is_action_just_pressed("triangle_shoot"):
		if shoot_count >= 9:
			for i in range(0,3):
				var scene = load("res://Scenes/Bullet.tscn")
				var scene_instance = scene.instance()
				scene_instance.set_name("bullet")
				scene_instance.set_position(Vector2(35,0).rotated(rotation) + position)
				scene_instance.set_rotation(rotation)
				scene_instance.init(Vector2(10,0).rotated(rotation-5+(i*5)), "player")
				get_parent().add_child(scene_instance)
			shoot_count = 0
		else:
			var scene = load("res://Scenes/Bullet.tscn")
			var scene_instance = scene.instance()
			scene_instance.set_name("bullet")
			scene_instance.set_position(Vector2(35,0).rotated(rotation) + position)
			scene_instance.set_rotation(rotation)
			scene_instance.init(Vector2(10,0).rotated(rotation), "player")
			get_parent().add_child(scene_instance)
			shoot_count += 1
