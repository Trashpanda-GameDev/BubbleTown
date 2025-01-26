extends Control

func _ready() -> void:
	BackgroundMusic.play_music()

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/town.tscn')

func _on_exit_game_pressed() -> void:
	get_tree().quit()
