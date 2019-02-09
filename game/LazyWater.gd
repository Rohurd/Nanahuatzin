extends Node2D

var Water = preload("res://Scenes/Water.tscn")

export(Color) var bot_color 
export(Color) var top_color
export(float) var cutoff

func _ready():
	call_deferred("lazy_water")

func lazy_water():
	var water = Water.instance()
	if bot_color:
		water.set_bot_color(bot_color)
	if top_color:
		water.set_top_color(top_color)
	if cutoff:
		water.set_cutoff(cutoff)
	get_parent().add_child_below_node(self, water)
	queue_free()
	
func set_bot_color(value):
	bot_color = value

func set_top_color(value):
	top_color = value
	
func set_cutoff(value):
	cutoff = value