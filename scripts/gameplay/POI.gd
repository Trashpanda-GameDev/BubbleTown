class_name POI extends Node

@export var thoughts_repository: ThoughtsRepository

@export var thought_resource: ThoughtResource

@export var use_default_collision_shape: bool = true
@export var collision_shape: CollisionShape2D

var thought: Thought

func _ready() -> void:
	if !use_default_collision_shape:
		collision_shape.set_deferred("disabled", true)

	thought = thoughts_repository.get_thought_by_resource(thought_resource)
