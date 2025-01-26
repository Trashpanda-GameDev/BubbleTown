extends Node

@export var rigidbody: RigidBody2D

@export var max_speed: int = 8
@export var acceleration: int = 50  
@export var drag: int = 30  
@export var acceleration_smoothing: float = 0.3
@export var movement_buffer: float = 0.1

@export var dash_multiplier: float = 1.8  # Quick burst of speed when starting movement

var velocity: Vector2 = Vector2.ZERO
var was_moving: bool = false

@onready var end_day_prompt: Control = $endOfDayPrompt

var _has_end_day_prompt: bool = false

signal endDayCycle

func _ready() -> void:
	$endOfDayPrompt.hide()

func get_movement_direction() -> Vector2:
	var up: float = Input.get_action_strength("movement_up")
	var down: float = Input.get_action_strength("movement_down")
	var left: float = Input.get_action_strength("movement_left")
	var right: float = Input.get_action_strength("movement_right")

	return Vector2(right - left, down - up)

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_movement_direction()
	var is_moving = direction.length() > 0
	
	if is_moving:
		# Apply dash multiplier when starting movement
		var speed_multiplier = dash_multiplier if !was_moving else 1.0
		velocity += direction * acceleration * speed_multiplier * delta
	
	# Sharp deceleration when stopping
	velocity -= velocity.normalized() * drag * delta
	
	if velocity.length_squared() > max_speed * max_speed:
		velocity = velocity.normalized() * max_speed
	
	# Quick stop when changing directions
	if !is_moving:
		velocity = velocity.move_toward(Vector2.ZERO, drag * 2 * delta)
	
	rigidbody.move_and_collide(velocity)
	was_moving = is_moving
	
@export var has_end_day_prompt: bool = false:
	get:
		return _has_end_day_prompt
	set(value):
		toggle_end_day_prompt(value)
		_has_end_day_prompt = value

func toggle_end_day_prompt(show_prompt: bool) -> void:
	if show_prompt:
		$endOfDayPrompt.show()
	else:
		$endOfDayPrompt.hide()

func _on_player_house_toggle_end_day_prompt(show_prompt: bool) -> void:
	has_end_day_prompt = show_prompt

func _on_yes_btn_pressed() -> void:
	endDayCycle.emit()
