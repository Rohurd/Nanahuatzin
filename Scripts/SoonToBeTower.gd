extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var max_to_build = 8
var build = 0
var rects = []
export var color = Color(0/255, 190.25/255, 170/255)
export var mark_color = Color(255/255, 255/255, 0/255)

func _ready():
	unmark()
	add_to_group("SoonToBeTower")
	add_to_group("tower")
	rects = [$ColorRect, $ColorRect2,$ColorRect3,$ColorRect4,$ColorRect5,$ColorRect6,$ColorRect7,$ColorRect8]
	
func _change_to_tower():
	var scene = load("res://Scenes/Tower.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("tower")
	var world = get_node("/root")
	scene_instance.set_position(position)
	world.add_child(scene_instance) 
	queue_free()
	
func build():
	if max_to_build == build:
		_change_to_tower()
		return
	rects[build].show()
	build += 1
	
func mark():
	$Main.modulate = mark_color

func unmark():
	$Main.modulate = color
	
func body_detected(other):
	if other.is_in_group("tower"):
		queue_free()

func collision_detected(other):
	if other.is_in_group("tower"):
		if get_instance_id() > other.get_instance_id():
			queue_free()
