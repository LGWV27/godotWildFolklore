extends AudioStreamPlayer

const level_music = preload("res://Assets/Sound/BeepBox-Song(1).mp3")







func _play_music(music: AudioStream, volume = -8.0):
	if stream == music:
		play()
	
	stream = music
	volume_db = volume
	if Resources.musicOFF == false:
		play()
	else:
		pass
	
func play_music_level():
	if Resources.musicOFF == false:
		_play_music(level_music)
		
	else:
		stop()

func play_FX(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	
	if Resources.fxOFF == false:
		fx_player.play()
	else:
		pass
	
	await fx_player.finished
	
	fx_player.queue_free()
