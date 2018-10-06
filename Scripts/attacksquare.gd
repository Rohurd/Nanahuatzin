extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var objects = []
var t = 0.0
export var total_length = 0.15

func _ready():
	$Timer.wait_time = total_length
	$Sprite.get_material().set_shader_param("t", t)

func _process(delta):
	t += delta / total_length
	$Sprite.get_material().set_shader_param("t", t)

func on_collide(obj):
	if obj.is_in_group("enemy") or obj.is_in_group("bullet"):
		obj.destroy()

func activate():

	queue_free()
