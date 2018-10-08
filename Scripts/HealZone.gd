extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var close = []
var t = 0
var max_t = 5
export var active = false

signal healed()

func _ready():
	connect("body_entered", self, "player_close")
	connect("body_exited", self, "player_away")
	

func _process(delta):
	if active:
		var someone_alive = false
		for obj in close:
			if obj.health > 0:
				someone_alive = true
				break
		if someone_alive:
			t += delta
		else:
			t -= delta
		if t >= max_t:
			emit_signal("healed")
			t = 0
		if t <0:
			t = 0
		$TextureProgress.value = t
	
func player_close(obj):
	if obj.is_in_group("player"):
		close.append(obj)

func player_away(obj):
	if obj.is_in_group("player"):
		close.erase(obj)