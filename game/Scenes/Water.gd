extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var o = LevelStatus.camera.get_camera_position()
	get_material().set_shader_param("x_trans", o.x)
	get_material().set_shader_param("y_trans", o.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
