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
