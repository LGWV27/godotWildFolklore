extends Control

const winner = preload("res://Assets/Sound/521639__fupicat__winbrass.wav")

var music_setting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	music_setting = Resources.musicOFF
	
	Resources.musicOFF = true
	
	AudioPlayer.play_music_level()
	
	if Resources.endSuccess == true:
		$MarginContainer/VBoxContainer/WinorLose.set_text("You  Won!")
		AudioPlayer.play_FX(winner, -12)
		
	else:
		$MarginContainer/VBoxContainer/WinorLose.set_text("Try  again?")
	
	if Resources.noDamage == true:
		$MarginContainer/VBoxContainer/NoDamage.set_text("No  Damage!")
	else:
		$MarginContainer/VBoxContainer/NoDamage.set_text(" ")
		
	if Resources.killAll == 11:
		$MarginContainer/VBoxContainer/KillAll.set_text("Killed  Everything!")
	else:
		$MarginContainer/VBoxContainer/KillAll.set_text(" ")
		
	if Resources.finishSpeech == true:
		$"MarginContainer/VBoxContainer/Finish Speech".set_text("Full  Speech!")
	else:
		$"MarginContainer/VBoxContainer/Finish Speech".set_text(" ")
	
	if Resources.finishSpeech == false and Resources.killAll != 11 and Resources.noDamage == false and Resources.endSuccess == false:
		$MarginContainer/VBoxContainer/KillAll.set_text("No  Achievements :(")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Resources.musicOFF = music_setting
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
