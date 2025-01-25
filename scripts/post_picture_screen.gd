extends Control

func handle_end_of_day() -> void:
	get_tree().paused = true
	self.visible = true

func _on_timer_timeout() -> void:
	handle_end_of_day()

func _on_player_end_day_cycle() -> void:
	handle_end_of_day()
