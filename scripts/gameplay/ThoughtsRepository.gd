class_name ThoughtsRepository extends Resource

@export var thought_resources: Array[ThoughtResource] = []

func is_thought_resource_id_valid(id: int) -> bool:
	return id > 0 && id < len(thought_resources)

func get_thought_by_resource_id(id: int) -> Thought:
	if is_thought_resource_id_valid(id):
		return Thought.new(randi(), id, self)

	return null

func get_thought_texture_by_resource_id(id: int) -> Texture2D:
	if is_thought_resource_id_valid(id):
		return thought_resources[id].texture

	return null

func get_thought_sprite_by_resource_id(id: int) -> Sprite2D:
	if is_thought_resource_id_valid(id):
		return thought_resources[id].get_sprite()

	return null
