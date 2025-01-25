class_name Thought extends Object

@export var id: int
@export var resource_id: int

var repository: ThoughtsRepository

func _init(id: int, resource_id: int, repository: ThoughtsRepository) -> void:
	self.id = id
	self.resource_id = resource_id

	self.repository = repository

func get_sprite() -> Sprite2D:
	return repository.get_thought_sprite_by_resource_id(self.resource_id)
