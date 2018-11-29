extends Node2D

export var bottomcolor = Color(0.99, 0.87, 0.67, 1.0)
export var topcolor = Color(0.99, 0.87, 0.67, 1.0)

var PlayerController = preload("res://Scenes/PlayerController.tscn")
var Char = preload("res://Scenes/RedChar.tscn")

const RedChar = preload("res://Scripts/RedChar.gd")

var players_ready = 0
var max_players = 15

func _ready():
	$Collision.hide()
	get_tree().get_root().connect("size_changed", self, "_on_screen_resized")
	_on_screen_resized()
	$Water.set_bot_color(bottomcolor)
	$Water.set_top_color(topcolor)
	$Water.set_cutoff(0.9)
	$play_area.connect("body_entered", self, "_on_play_area_enter")
	$play_area.connect("body_exited", self, "_on_play_area_edit")
	$OptionArea.connect("body_entered", self, "_on_option_area_enter")
	

func _on_screen_resized():
	var projectResolution = get_viewport().size
	find_node("Water").scale = Vector2(projectResolution.x / 300, projectResolution.y / 50)

func _process(delta):
	
	if Input.is_action_just_pressed("new_player"):
		var i = len(LevelStatus.players)
		if i <= max_players:
			LevelStatus.players.append(null)
			if LevelStatus.players[i] == null:
				var player = PlayerController.instance()
				player.index = i
				LevelStatus.players[i] = player
				LevelStatus.add_child(player)
				var character = Char.instance()
				character.controller = player
				character.position = $Spawn.position
				$Players.add_child(character)
				
func start_game():
	var Level = load("res://Scenes/Level.tscn")
	var level = Level.instance()
	level.set_name("Level")
	$"/root".add_child(level)
	queue_free()
	
func _on_option_area_enter(player):
	if player is RedChar:
		var Options = load("res://Scenes/Options.tscn")
		var options = Options.instance()
		$HUDCanvas.add_child(options)
				
func _on_play_area_enter(player):
	if player is RedChar:
		players_ready += 1
	var player_count = len(LevelStatus.players)
	if player_count > 0  and players_ready == len(LevelStatus.players):
		start_game()
		
func _on_play_area_exit(player):
	if player is RedChar:
		players_ready -= 1
	