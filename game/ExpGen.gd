extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var big_i = 0
var big_max_i = 20
var bigs = []

var small_i = 0
var small_max_i = 20
var smalls = []

func _ready():
	var explosion = load("res://Scenes/Explosion.tscn")
	for k in range(big_max_i):
		var ent = explosion.instance()
		ent.hide()
		add_child(ent)
		bigs.append(ent)
	var small_explosion = load("res://Scenes/SmallExplosion.tscn")
	for k in range(big_max_i):
		var ent = small_explosion.instance()
		add_child(ent)
		ent.hide()
		smalls.append(ent)
	gen_exp_big(Vector2(-200,-200))

func free_again(explosion):
	explosion.position = Vector2(0,0)
	explosion.hide()
	
func gen_exp_big(position):
	var explosion = bigs[big_i]
	explosion.position = position
	explosion.play()
	big_i = (big_i+1) % big_max_i
	
func gen_exp_small(position):
	var explosion = smalls[small_i]
	explosion.position = position
	explosion.play()
	small_i = (small_i+1) % small_max_i