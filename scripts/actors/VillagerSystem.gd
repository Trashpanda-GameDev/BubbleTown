class_name VillagerSystem extends Node

@export var thought: VillagerThoughtController

@export_group("UI")
@export var thoughtView: VillagerThoughtView

func _ready() -> void:
	thought.on_thought_changed.connect(_handle_thought_change)
	thought.on_thought_cleared.connect(_handle_thought_clear)

func _show_thought_on_player_collision_start(_body: Node2D) -> void:
	var current_thought: Thought = thought.get_thought()
	if current_thought == null:
		return

	thoughtView.texture.texture = current_thought.get_texture()
	thoughtView.visible = true

func _hide_thought_on_player_collision_start(_body: Node2D) -> void:
	thoughtView.texture.texture = null
	thoughtView.visible = false

func _handle_thought_change(thought: Thought) -> void:
	if thoughtView.visible:
		thoughtView.texture.texture = thought.get_texture()

func _handle_thought_clear() -> void:
	thoughtView.texture.texture = null
	thoughtView.visible = false
