class_name VillagerThoughtController extends Node

var thought: Thought

signal on_thought_changed(thought: Thought)
signal on_thought_cleared

func has_thought() -> bool:
	return thought != null

func get_thought() -> Thought:
	return thought

func clear_thought() -> void:
	thought = null

	on_thought_cleared.emit()

func set_thought(thought: Thought) -> void:
	assert(thought != null, "thought is not allowed to be set to <null>; use `clear_thought` instead")
	self.thought = thought

	on_thought_changed.emit(thought)
