extends Control

@export var end_day_prompt: Control
var _has_end_day_prompt: bool = false

signal end_day_cycle

func _ready() -> void:
	end_day_prompt.hide()
	
@export var has_end_day_prompt: bool = false:
	get:
		return _has_end_day_prompt
	set(value):
		toggle_end_day_prompt(value)
		_has_end_day_prompt = value

func toggle_end_day_prompt(show_prompt: bool) -> void:
	if show_prompt:
		end_day_prompt.show()
	else:
		end_day_prompt.hide()

func _on_yes_btn_pressed() -> void:
	end_day_cycle.emit()

func _on_player_toggle_prompt_message(show_prompt: bool) -> void:
	has_end_day_prompt = show_prompt
