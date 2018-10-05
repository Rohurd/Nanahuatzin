extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 250
export var radius = 15

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	var velocity = Vector2() # The player's movement vector.
	var projectResolution=Vector2(get_viewport().size)
	if Input.is_action_pressed("triangle_right") && position.x <= projectResolution.x - radius:
		velocity.x += 1
	if Input.is_action_pressed("triangle_left") && position.x >= radius:
		velocity.x -= 1
	if Input.is_action_pressed("triangle_down") && position.y <= projectResolution.y - radius:
		velocity.y += 1
	if Input.is_action_pressed("triangle_up") && position.y >= radius:
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide(velocity)