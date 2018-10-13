extends TextureProgress

export var round_count = 0
var playing = true

export var pause_time = 7
var level_time = 0
export var starting_level_time = 20
export var level_time_increase = 5

enum states {PAUSED, BUILD, BATTLE}
var state = states.PAUSED

func _ready():
	level_time = starting_level_time
	start()

func _process(delta):
	match state:
		PAUSED:
			pass
		BUILD:
			value += (100 / pause_time) * delta
			if value >= 100:
				end_pause()
				start_level()
		BATTLE:
			value -= (100 / level_time) * delta
			if value <= 0:
				end_level()
				start_pause()

func start():
	value = 0
	state = states.BUILD

func start_level():
	state = states.BATTLE
	LevelStatus.paused = false
	value = 100
	$"/root/Level/HUD/ModeLabel/AnimationPlayer".play("battle")
	$"/root/Level/Sounds/BattleStart".play()
	
	yield(get_tree().create_timer(level_time-3), "timeout")
	$"/root/Level/Sounds/Three".play()
	yield(get_tree().create_timer(1), "timeout")
	$"/root/Level/Sounds/Two".play()
	yield(get_tree().create_timer(1), "timeout")
	$"/root/Level/Sounds/One".play()
	yield(get_tree().create_timer(1), "timeout")

func end_level():
	level_time += level_time_increase
	LevelStatus.max_enemies += 10
	round_count += 1
	
func start_pause():
	state = states.BUILD
	LevelStatus.paused = true
	$"/root/Level/HUD/ModeLabel/AnimationPlayer".play("build")
	
	

func end_pause():
	pass

