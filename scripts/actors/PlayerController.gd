class_name PlayerController extends Node

@export var movement: PlayerMovement

@export var day_end_prompt: Control

var _has_end_day_prompt: bool = false

var _current_villager: VillagerSystem
var _is_near_villager: bool = false

func _ready() -> void:
	day_end_prompt.hide()

@export var has_end_day_prompt: bool = false:
	get:
		return _has_end_day_prompt
	set(value):
		toggle_end_day_prompt(value)
		_has_end_day_prompt = value

func toggle_end_day_prompt(show_prompt: bool) -> void:
	if show_prompt:
		day_end_prompt.show()
	else:
		day_end_prompt.hide()

func _on_player_house_toggle_end_day_prompt(show_prompt: bool) -> void:
	has_end_day_prompt = show_prompt

func _on_yes_btn_pressed() -> void:
	day_end_prompt.emit()

func _on_villager_nearby(body: Node2D) -> void:
	var parent: Node = body.get_parent()
	if !(parent is VillagerSystem):
		return

	_current_villager = parent
	_is_near_villager = true

func _on_villager_afar(body: Node2D) -> void:
	var parent: Node = body.get_parent()
	if _current_villager != parent:
		return

	_current_villager = null
	_is_near_villager = false
