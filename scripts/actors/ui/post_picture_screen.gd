extends Control

func handle_end_of_day() -> void:
	#get_tree().paused = true
	self.visible = true

func _on_post_btn_pressed() -> void:
	get_tree().reload_current_scene()

func _on_next_day_btn_pressed() -> void:
	get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	handle_end_of_day()

func _on_player_show_post_photo_panel() -> void:
	handle_end_of_day()
