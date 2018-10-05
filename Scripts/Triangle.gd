extends "res://Scripts/Movement_Rotation.gd"

func _ready():
	add_to_group("players")

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
	move_rotate(velocity, delta)
