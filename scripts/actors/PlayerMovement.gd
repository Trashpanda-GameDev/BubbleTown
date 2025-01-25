extends Node

@export var character: CharacterBody2D

@export var max_speed: int = 3
@export var acceleration: int = 40
@export var drag: int = 20

var velocity: Vector2 = Vector2.ZERO

func get_movement_direction() -> Vector2:
	var up: float = Input.get_action_strength("movement_up")
	var down: float = Input.get_action_strength("movement_down")
	var left: float = Input.get_action_strength("movement_left")
	var right: float = Input.get_action_strength("movement_right")

	return Vector2(right - left, down - up)

func _physics_process(delta: float) -> void:
	var previous_velocity: Vector2 = velocity

	var direction: Vector2 = get_movement_direction()
	velocity += direction * acceleration * delta

	velocity -= velocity.normalized() * drag * delta

	# if the velocity vector suddenly changed direction more than 90°
	# then the drag should have consumed all the velocity
	if previous_velocity.dot(velocity) < 0:
		velocity = Vector2.ZERO

	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed

	character.move_and_collide(velocity)
