class_name PlayerMovement extends Node

@export var rigidbody: RigidBody2D
@export var sprite: Sprite2D
@export var walk_left_texture: Texture
@export var walk_right_texture: Texture

@export var max_speed: int = 8
@export var acceleration: int = 50  
@export var drag: int = 30  
@export var acceleration_smoothing: float = 0.3
@export var movement_buffer: float = 0.1

@export var dash_multiplier: float = 1.8  # Quick burst of speed when starting movement
@export var sprint_multiplier: float = 1.5  # Speed multiplier when sprinting
@export var sprint_acceleration: float = 1.2  # How quickly sprint builds up

var velocity: Vector2 = Vector2.ZERO
var was_moving: bool = false
var is_sprinting: bool = false

func get_movement_direction() -> Vector2:
	var up: float = Input.get_action_strength("movement_up")
	var down: float = Input.get_action_strength("movement_down")
	var left: float = Input.get_action_strength("movement_left")
	var right: float = Input.get_action_strength("movement_right")

	return Vector2(right - left, down - up)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_movement_direction()
	var is_moving = direction.length() > 0
	
	# Handle sprite flipping based on movement direction
	if direction.x != 0:
		sprite.texture = walk_right_texture if direction.x > 0 else walk_left_texture
	
	# Check if sprint button is held
	is_sprinting = Input.is_action_pressed("sprint")
	
	if is_moving:
		# Apply dash multiplier when starting movement
		var speed_multiplier = dash_multiplier if !was_moving else 1.0
		# Apply sprint multiplier if sprinting
		speed_multiplier *= sprint_multiplier if is_sprinting else 1.0
		
		velocity += direction * acceleration * speed_multiplier * delta
	
	# Sharp deceleration when stopping
	velocity -= velocity.normalized() * drag * delta
	
	var current_max_speed = max_speed * (sprint_multiplier if is_sprinting else 1.0)
	
	if velocity.length_squared() > current_max_speed * current_max_speed:
		velocity = velocity.normalized() * current_max_speed
	
	# Quick stop when changing directions
	if !is_moving:
		velocity = velocity.move_toward(Vector2.ZERO, drag * 2 * delta)
	
	rigidbody.move_and_collide(velocity)
	was_moving = is_moving
