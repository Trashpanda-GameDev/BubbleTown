class_name ThoughtInventoryItemView extends Control

@export var textureRect: TextureRect

var thought: Thought

func set_thought(thought: Thought) -> void:
	self.thought = thought
	textureRect.texture = thought.get_texture()
