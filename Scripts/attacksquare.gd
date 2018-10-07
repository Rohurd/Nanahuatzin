extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var objects = []
var t = 0.0 setget set_t
export var total_length = 1.0
export var tween_length = 0.1

var active = false

signal finished()

func set_t(value):
	$Sprite.get_material().set_shader_param("t", value)
	
func activate():
	active = true
	$Tween.interpolate_property(self, "t", 0, 1.1, tween_length, Tween.TRANS_QUAD, Tween.EASE_IN, 0)
	$Tween.interpolate_property(self, "t", 1.1, 0, tween_length, Tween.TRANS_QUAD, Tween.EASE_IN, total_length-tween_length)
	$Tween.start()
	yield(get_tree().create_timer(total_length), "timeout")
	active = false
	emit_signal("finished")
	
func _process(delta):
	if active: 
		for obj in objects:
			obj.destroy()
			if obj.is_in_group("enemy"):
				$"/root/Level/HUD/Points".text = str(int($"/root/Level/HUD/Points".text) + 1)
		objects = []

func on_collide(obj):
	if obj.is_in_group("enemy") or obj.is_in_group("bullet"):
		objects.append(obj)

func on_exit(obj):
	objects.erase(obj)

