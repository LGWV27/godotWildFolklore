extends Control


func _ready():
	if Resources.musicOFF == false:
		$MarginContainer/VBoxContainer/Music.set_text("Music - CURRENTLY ON")
	else:
		$MarginContainer/VBoxContainer/Music.set_text("Music - CURRENTLY OFF")
	if Resources.fxOFF == false:
		$"MarginContainer/VBoxContainer/Audio FX".set_text("Audio FX - CURRENTLY ON")
	else:
		$"MarginContainer/VBoxContainer/Audio FX".set_text("Audio FX - CURRENTLY OFF")

func _on_volume_pressed():
	if Resources.musicOFF == false:
		Resources.musicOFF = true
		$MarginContainer/VBoxContainer/Music.set_text("Music - CURRENTLY OFF")
		AudioPlayer.play_music_level()
	else:
		Resources.musicOFF = false
		$MarginContainer/VBoxContainer/Music.set_text("Music - CURRENTLY ON")
		AudioPlayer.play_music_level()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	AudioPlayer.play_music_level()


func _on_audio_fx_pressed():
	if Resources.fxOFF == false:
		Resources.fxOFF = true
		$"MarginContainer/VBoxContainer/Audio FX".set_text("Audio FX - CURRENTLY OFF")
	else:
		Resources.fxOFF = false
		$"MarginContainer/VBoxContainer/Audio FX".set_text("Audio FX - CURRENTLY ON")
