extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var objects = []
var t = 0.0 setget set_t
export var total_length = 1.0
export var tween_length = 0.1

func set_t(value):
	$Sprite.get_material().set_shader_param("t", value)
	

func _ready():
	$Tween.interpolate_property(self, "t", 0, 1, tween_length, Tween.TRANS_QUAD, Tween.EASE_IN, 0)
	$Tween.interpolate_property(self, "t", 1, 0, tween_length, Tween.TRANS_QUAD, Tween.EASE_IN, total_length-tween_length)
	$Tween.start()
	$Timer.wait_time = total_length
	$Timer.start()

func on_collide(obj):
	if obj.is_in_group("enemy") or obj.is_in_group("bullet"):
		obj.destroy()

func activate():

	queue_free()
