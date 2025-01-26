class_name PlayerMovement extends Node

@export var rigidbody: RigidBody2D

@export var max_speed: int = 4
@export var acceleration: int = 40
@export var drag: int = 20

var velocity: Vector2 = Vector2.ZERO

signal endDayCycle

func get_movement_direction() -> Vector2:
	var up: float = Input.get_action_strength("movement_up")
	var down: float = Input.get_action_strength("movement_down")
	var left: float = Input.get_action_strength("movement_left")
	var right: float = Input.get_action_strength("movement_right")

	return Vector2(right - left, down - up)

func _physics_process(delta: float) -> void:
	var previous_velocity: Vector2 = velocity

	var direction: Vector2 = get_movement_direction()

	if direction.length_squared() > 0:
		velocity += direction * acceleration * delta
		velocity -= velocity * Vector2(-direction.y, direction.x) * drag * delta
	else:
		velocity -= velocity.normalized() * drag * delta
		# if the velocity vector suddenly changed direction more than 90°
		# then the drag should have consumed all the velocity
		if previous_velocity.dot(velocity) < 0:
			velocity = Vector2.ZERO

	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed

	rigidbody.move_and_collide(velocity)
