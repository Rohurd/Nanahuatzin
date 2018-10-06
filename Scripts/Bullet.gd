extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func init(var velo):
	velocity = velo
	pass

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	position.x += velocity.x
	position.y += velocity.y
	var projectResolution=get_viewport().size
	if position.x > projectResolution.x || position.y > projectResolution.y:
		queue_free()
	pass
	
func destroy():
	queue_free()
	
func collision_detection(obj):
	destroy()
	if obj.is_in_group("enemy"):
		obj.destroy()
