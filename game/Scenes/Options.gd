extends Control

var difficulties = ["Easy","Medium","Hard"]

func _ready():
	$Bg/Center/Vbox/Effects/EffectsSlider.connect("value_changed", self, "_on_effects_value_changed")
	$Bg/Center/Vbox/Effects/EffectsSlider.connect("gui_input", self, "_on_EffectsVolumeSlider_gui_input")
	$Bg/Center/Vbox/Music/MusicVolumeSlider.connect("value_changed", self, "_on_music_value_changed")
	$Bg/Center/Vbox/Music/MusicVolumeSlider.connect("gui_input", self, "_on_MusicVolumeSlider_gui_input")
	$Back.connect("pressed", self, "_on_close")
	$Bg/Center/Vbox/Difficulty/Difficulty.connect("value_changed", self, "_on_difficulty_value_changed")
	
func _on_effects_value_changed(value):
	$Bg/Center/Vbox/Effects/EffectNumber.text = str(value)
	$Bg/Center/Vbox/Effects/EffectsSlider.value = value
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), voldb)
	
func _on_music_value_changed(value):
	$Bg/Center/Vbox/Music/MusicVolumeValueLabel.text = str(value)
	$Bg/Center/Vbox/Music/MusicVolumeSlider.value = value
	var voldb = 20 * log(value / 100)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), voldb)
	
func _on_difficulty_value_changed(value):
	$Bg/Center/Vbox/Difficulty/HSplitContainer/DifficultyValueLabel.text = difficulties[int(value)]
	LevelStatus.difficulty = value

func _on_MusicVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$MusicTestSound.play()

func _on_EffectsVolumeSlider_gui_input(ev):
	if (ev is InputEventMouseButton) && !ev.pressed && (ev.button_index == BUTTON_LEFT):
		$EffectsTestSound.play()
		
func _on_close():
	queue_free()