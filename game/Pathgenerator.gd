extends Node2D


var RedDot = preload("res://Scenes/RedDot.tscn")

var all = {}
var STEP = 32
var movements = [STEP * Vector2(1, 0), STEP*Vector2(0,1), STEP*Vector2(-1, 0), STEP*Vector2(0, -1)]

var current = [Vector2(1000, 500)]

var once = true
var next = false

func _ready():
	pass
	
func contains(a, b):
	return b.has(a)
	
func hitscan(a, b, space_state):
	return space_state.intersect_ray(a, b)
	
func tick(space_state):
	var parent = get_parent()
	var i = 0
	var count = 0
	var count2 = 0
	while len(current) > 0 and i < 20:
		var cur = current.pop_back()
		for mov in movements:
			var new = cur + mov
			if contains(new, all):
				continue
			var r = hitscan(cur, new, space_state)
			count += 1
			if not r and 0 <= new.x and new.x < 5000 and 0 <= new.y and new.y < 5000:
				current.append(new)
				all[new] = null
				var dot = RedDot.instance()
				dot.position = new
				parent.add_child(dot)
				count2 += 1
		i += 1
	if len(current) == 0:
		return true
	else:
		return false
		
func _physics_process(delta):
	if next:
		var space_state = get_world_2d().direct_space_state
		next = not tick(space_state)
	if once:
		next = true
		once = false