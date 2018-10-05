extends KinematicBody2D

export var speed = 250
export var radius = 15

func _ready():
	add_to_group("players")

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	var projectResolution=get_viewport().size
	if Input.is_action_pressed("square_right"):
		velocity.x += 1
	if Input.is_action_pressed("square_left"):
		velocity.x -= 1
	if Input.is_action_pressed("square_down"):
		velocity.y += 1
	if Input.is_action_pressed("square_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		look_at(position + velocity)
	move_and_slide(velocity)
	position.x = clamp(position.x, radius, projectResolution.x - radius)
	position.y = clamp(position.y, radius, projectResolution.y - radius)
