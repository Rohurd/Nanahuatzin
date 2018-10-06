extends "res://Scripts/Entity.gd"

signal health_changed(player)

func _ready():
	health = 5
	max_health = 5
	add_to_group("player")
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
