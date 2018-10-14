extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()

func _process(delta):
	if LevelStatus.camera != null:
		var o = LevelStatus.camera.get_camera_position()
		get_material().set_shader_param("x_trans", o.x)
		get_material().set_shader_param("y_trans", o.y)
	
	
func _on_screen_resized():
	var projectResolution = get_viewport().size
	scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)
