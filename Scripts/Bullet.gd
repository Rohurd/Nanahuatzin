extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity
var owner_group

func _ready():
	add_to_group("bullet")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func init(velo, group):
	velocity = velo
	owner_group = group
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
	$"/root/Level/ExpGen".gen_exp_small(global_position)
	queue_free()
	
func collision_detection(obj):
	destroy()
	if obj.is_in_group("enemy") && owner_group != "enemy":
		obj.setHealth(obj.health -1)
		if obj.health == 0:
			$"/root/Level/HUD/Points".text = str(int($"/root/Level/HUD/Points".text) + 1)
	if !obj.is_in_group("enemy") && owner_group == "enemy":
		obj.setHealth(obj.health -1)
