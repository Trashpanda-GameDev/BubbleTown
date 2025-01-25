class_name ThoughtsInventory extends Object

var current_thoughts: Array[Thought] = []

@export var repository: ThoughtsRepository

func _init(repository: ThoughtsRepository) -> void:
	self.repository = repository

func get_thought_count(resource_id: int) -> int:
	var count: int = 0

	for thought in current_thoughts:
		if thought.resource_id == resource_id:
			count += 1

	return count

func add_thought(thought: Thought) -> void:
	current_thoughts.append(thought)

func remove_thought(thought: Thought) -> bool:
	for i in range(0, len(current_thoughts)):
		if thought == current_thoughts[i]:
			current_thoughts.remove_at(i)

			return true

	return false

func remove_thought_by_id(id: int) -> bool:
	for i in range(0, len(current_thoughts)):
		if id == current_thoughts[i].id:
			current_thoughts.remove_at(i)

			return true

	return false

func add_thought_by_resource_id(id: int) -> bool:
	var thought: Thought = repository.get_thought_by_resource_id(id)
	if thought == null:
		return false

	current_thoughts.append(thought)

	return true

func remove_thought_by_resource_id(id: int) -> bool:
	for i in range(0, len(current_thoughts)):
		if id == current_thoughts[i].resource_id:
			current_thoughts.remove_at(i)

			return true

	return false
