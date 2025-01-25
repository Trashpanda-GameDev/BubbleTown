class_name VillagersThoughtSystem extends Node

@export var villagers_system: VillagersSystem

@export var thoughts_repository: ThoughtsRepository

func _ready() -> void:
	var thought_resource_ids := thoughts_repository.get_thought_resource_ids()
	print(thought_resource_ids)
	print(thoughts_repository)

	for villager in villagers_system.villagers:
		var thought_resource_id := thought_resource_ids[randi_range(0, len(thought_resource_ids) - 1)]
		var thought := thoughts_repository.get_thought_by_resource_id(thought_resource_id)
		print(thought)
		villager.thought.set_thought(thought)
