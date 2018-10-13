extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
var owner_group = ""

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
	position.x += velocity.x
	position.y += velocity.y
	
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
