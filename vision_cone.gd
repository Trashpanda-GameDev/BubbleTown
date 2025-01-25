extends Node2D

# Main params
@export_category("Cone")
@export var cone_angle := 60.0 ## the angle of the cone in degrees
@export var cone_range := 200.0 ## how far the cone can reach
@export var cone_color := Color(1, 1, 1, 0.3) ## color of the cone
@export var rotation_speed := 10.0 ## Smoothing factor for rotation

@export_category("Raycasts")
@export var raycast_density := 32 ## the amount of raycasts spread throughout the cone more density is higher accuracy detection, but less performance
@export var update_frequency := 60.0 ## physics updates per second, higher number is less jitter but more calculations
@export_flags_2d_physics var detection_layers: int = 1 ## the layers of collision objects that can be detected by the raycasts

var cone_points: PackedVector2Array
var update_timer := 0.0
var target_rotation := 0.0

func _ready():
	check_obstacles()

func _draw():
	draw_colored_polygon(cone_points, cone_color)

func update_cone_shape():
	cone_points = PackedVector2Array()
	cone_points.append(Vector2.ZERO)
	
	var angle_start = -cone_angle / 2
	var angle_end = cone_angle / 2
	
	for i in range(raycast_density + 1):
		var angle = deg_to_rad(lerp(angle_start, angle_end, float(i) / raycast_density))
		var point = Vector2(
			cos(angle) * cone_range,
			sin(angle) * cone_range
		)
		cone_points.append(point)
	# Add this line to ensure visual update
	queue_redraw()

func _physics_process(delta):
	update_timer += delta
	if update_timer >= 1.0 / update_frequency:
		update_timer = 0.0
		check_obstacles()

func check_obstacles():
	var space_state = get_world_2d().direct_space_state
	var updated_points = PackedVector2Array([Vector2.ZERO])
	var angle_start = -cone_angle / 2
	var angle_end = cone_angle / 2
	var num_points = 32
	
	for i in range(num_points + 1):
		var angle = deg_to_rad(lerp(angle_start, angle_end, float(i) / num_points))
		var ray_direction = Vector2(cos(angle), sin(angle)) * cone_range
		
		var query = PhysicsRayQueryParameters2D.create(
			global_position,
			global_position + ray_direction.rotated(global_rotation)
		)
		query.collision_mask = detection_layers
		var result = space_state.intersect_ray(query)
		
		if result:
			print("result!", result.collider)
			# Convert hit position to local coordinates
			var local_collision = to_local(result.position)
			updated_points.append(local_collision)
		else:
			# If no hit, use full ray length
			updated_points.append(ray_direction)
	
	cone_points = updated_points
	queue_redraw()

func _process(delta):
	handle_mouse_input()
	handle_controller_input()
	# Smooth rotation
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)

func handle_mouse_input() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_global_mouse_position()
		target_rotation = (mouse_pos - global_position).angle()

func handle_controller_input() -> void:
	var stick_input = Vector2(
		Input.get_axis("camera_left", "camera_right"),
		Input.get_axis("camera_up", "camera_down")
	)
	
	if stick_input.length() > 0.1:  # Add deadzone
		target_rotation = stick_input.angle()
