extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var speed = 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("triangle_right"):
		velocity.x += 1
	if Input.is_action_pressed("triangle_left"):
		velocity.x -= 1
	if Input.is_action_pressed("triangle_down"):
		velocity.y += 1
	if Input.is_action_pressed("triangle_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta