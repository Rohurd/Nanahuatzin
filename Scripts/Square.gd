extends "res://Scripts/Movement_Rotation.gd"

export var health = 5 setget setHealth
export var max_health = 5

signal health_changed(player)

func _ready():
	add_to_group("players")
	emit_signal("health_changed", self)

func setHealth(value):
	print(value)
	if value != health:
		health = value
		emit_signal("health_changed", self)
		

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("square_right"):
		velocity.x += 1
	if Input.is_action_pressed("square_left"):
		velocity.x -= 1
	if Input.is_action_pressed("square_down"):
		velocity.y += 1
	if Input.is_action_pressed("square_up"):
		velocity.y -= 1
	move_rotate(velocity, delta)
	
	if Input.is_action_just_pressed("square_shoot"):
		var scene = load("res://Scenes/Bullet.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("bullet")
		scene_instance.set_position(Vector2(20,0).rotated(rotation) + position)
		scene_instance.init(Vector2(10,0).rotated(rotation))
		get_parent().add_child(scene_instance)
