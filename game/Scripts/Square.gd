extends "res://Scripts/Entity.gd"

signal health_changed(player)

export var attack_cd = 0.5
var attacking = false

func _ready():
	LevelStatus.players_living += 1
	health = 5
	max_health = 5
	add_to_group("player")
	connect("health_changed", self, "burn")
	$HealZone.connect("healed", self, "revive")
	connect("health_changed", $"/root/Level/HUD/SquareHealth", "health_changed")
	emit_signal("health_changed", self)
	
func revive():
	LevelStatus.players_living += 1
	setHealth(2)
	
func burn(player):
	if health <= 0:
		$Particles2D.emitting = true
		$HealZone.show()
		$HealZone.active = true
	else:
		$Particles2D.emitting = false
		$HealZone.hide()
		$HealZone.active = false
		$HealZone.t = 0
	
func attack():
	if not attacking:
		attacking = true
		var old_speed = speed
		speed = 20
		$ShieldAbility.activate()
		yield($ShieldAbility, "finished")
		speed = old_speed
		yield(get_tree().create_timer(attack_cd), "timeout")
		attacking = false

func get_velocity():
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("square_right"):
		velocity.x += 1
	if Input.is_action_pressed("square_left"):
		velocity.x -= 1
	if Input.is_action_pressed("square_down"):
		velocity.y += 1
	if Input.is_action_pressed("square_up"):
		velocity.y -= 1
	return velocity
	
func _process(delta):
	if health > 0 && Input.is_action_just_pressed("square_attack") && !LevelStatus.paused:
		attack()

func _physics_process(delta):
	if health > 0:
		var velocity = get_velocity()
		self.rotation = calc_rotation(self.rotation, velocity, delta)
		move(velocity,delta)
