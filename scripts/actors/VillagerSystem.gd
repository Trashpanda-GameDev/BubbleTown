class_name VillagerSystem extends Node

@export var thought: VillagerThoughtController

@export_group("UI")
@export var thoughtView: VillagerThoughtView

func _show_thought_on_player_collision_start(body: Node2D) -> void:
	var current_thought: Thought = thought.get_thought()
	if current_thought == null:
		return

	thoughtView.texture.texture = current_thought.get_texture()
	thoughtView.visible = true

func _hide_thought_on_player_collision_start(body: Node2D) -> void:
	thoughtView.visible = false
