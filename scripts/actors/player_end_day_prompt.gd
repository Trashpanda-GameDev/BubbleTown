extends Node

#var has_end_day_prompt: get = get_has_end_day_prompt, set = set_has_end_day_prompt

@onready var end_day_prompt: Control = $endOfDayPrompt

var _has_end_day_prompt: bool = false
@export var has_end_day_prompt: bool = false:
	get:
		return _has_end_day_prompt
	set(value):
		toggle_end_day_prompt(value)
		_has_end_day_prompt = value

func toggle_end_day_prompt(is_player_house) -> void:
	if is_player_house != null:
		$endOfDayPrompt.show()
	else:
		$endOfDayPrompt.hide()

func _on_toggle_end_day_prompt(show_prompt: bool):
	print('show prompt')
	
