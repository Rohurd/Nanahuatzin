extends Sprite

func _ready():
	hide()
	self.position = self.position.rotated(-$"..".rotation)
	self.rotation = -$"..".rotation
