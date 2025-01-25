class_name VillagerThoughtController extends Node

var thought: Thought

func has_thought() -> bool:
	return thought != null

func get_thought() -> Thought:
	return thought

func clear_thought() -> void:
	thought = null

func set_thought(thought: Thought) -> void:
	assert(thought != null, "thought is not allowed to be set to <null>; use `clear_thought` instead")
	self.thought = thought
