class_name PlayerController extends Node

@export var movement: PlayerMovement

var _current_villager: VillagerSystem
var _is_near_villager: bool = false

signal show_post_photo_panel
signal toggle_prompt_message

func _on_player_house_toggle_end_day_prompt(show_prompt: bool) -> void:
	toggle_prompt_message.emit(show_prompt)

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

func _on_prompt_message_end_day_cycle() -> void:
	show_post_photo_panel.emit()
	
