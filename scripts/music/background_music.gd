extends AudioStreamPlayer

var level_music = preload("res://audio/main_bg_music.mp3")

func play_music(volume: float = 0.0) -> void:
	volume_db = volume
	play()
