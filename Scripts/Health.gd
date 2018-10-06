extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var health = 0
var nodes = []

func _ready():
	pass
	
func health_changed(player):
	var heart = load("res://Scenes/Heart.tscn")
	var max_health = player.max_health
	health = player.health
	
	for node in nodes:
		remove_child(node)
	nodes = []
	
	for i in range(health):
		var h = heart.instance()
		add_child(h)
		nodes.append(h)
	for i in range(max_health - health):
		var h = heart.instance()
		h.modulate = Color(0,0,0,1)
		add_child(h)
		nodes.append(h)
