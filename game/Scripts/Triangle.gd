extends "res://Scripts/Entity.gd"

signal health_changed(player)

var shoot_count = 0
var vel = 0.5
export var rotation_resistence = 20
var size = 1

func _ready():
	speed = 100
	LevelStatus.camera = $Camera
	LevelStatus.players_living += 1
	health = 5
	max_health = 5
	add_to_group("player")
	connect("health_changed", self, "health_changed")
	$HealZone.connect("healed", self, "revive")
	connect("health_changed", $"/root/Level/HUD/TriangleHealth", "health_changed")
	emit_signal("health_changed", self)
	LevelStatus.ship = self
	var size = $Sprite.texture.get_size()
	self.size = size.x
	
func health_changed(player):
	if health > 0:
		$Particles2D.emitting = false
		$HealZone.hide()
		$HealZone.active = false
		$HealZone.t = 0

func revive():
	LevelStatus.players_living += 1
	setHealth(2)
	
func destroy():
	$Particles2D.emitting = true
	$HealZone.show()
	$HealZone.active = true

func get_velocity():
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("triangle_right"):
		velocity.x += 1
	if Input.is_action_pressed("triangle_left"):
		velocity.x -= 1
	if Input.is_action_pressed("triangle_down"):
		velocity.y += 1
	if Input.is_action_pressed("triangle_up"):
		velocity.y -= 1
	return velocity
	
func shooot(origin, direction):
	origin = origin * self.size
	origin = origin.rotated(self.rotation - PI/2)
	direction = direction.rotated(self.rotation - PI/2)
	origin += self.position
	var Bullet = load("res://Scenes/Bullet.tscn")
	var bullet = Bullet.instance()
	bullet.set_name("bullet")
	bullet.set_position(origin)
	bullet.init(direction, "player")
	get_parent().add_child(bullet)
	$"/root/Level/Sounds/BigShoot".play()

func shoot():
	if shoot_count >= 9:
		for i in range(0,3):
			var scene = load("res://Scenes/Bullet.tscn")
			var scene_instance = scene.instance()
			scene_instance.set_name("bullet")
			scene_instance.set_position(Vector2(40,0).rotated(rotation) + position)
			scene_instance.set_rotation(rotation)
			scene_instance.init(Vector2(10,0).rotated(rotation-5+(i*5)), "player")
			get_parent().add_child(scene_instance)
		shoot_count = 0
		
		$"/root/Level/Sounds/BigShoot".play()
	else:
		var scene = load("res://Scenes/Bullet.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("bullet")
		scene_instance.set_position(Vector2(40,0).rotated(rotation) + position)
		scene_instance.set_rotation(rotation)
		scene_instance.init(Vector2(10,0).rotated(rotation), "player")
		get_parent().add_child(scene_instance)
		shoot_count += 1
		
		$"/root/Level/Sounds/BigShoot".play()
		
func helm(rot):
	rotation += rot / rotation_resistence

func _physics_process(delta):
	var vec = Vector2(1, 0)
	vec = vec.rotated(rotation) * vel
	vec = vec * speed
	move_and_slide(vec)