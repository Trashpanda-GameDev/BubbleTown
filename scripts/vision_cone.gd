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
@export_flags_2d_physics var blocking_layers: int = 1 ## the layers of collision objects that can be detected by the raycasts and block vision
@export_flags_2d_physics var pass_through_layers: int = 2  ## the layers of collision objects that can be detected by the raycasts

var cone_points: PackedVector2Array
var iso_y_scale := 0.58  # Typical isometric Y scale factor
var current_rotation := 0.0
var update_timer := 0.0
var target_rotation := 0.0
var hit_objects: Dictionary = {}

func _ready() -> void:
	if(!self.visible): return;
	
	check_obstacles()

func _draw() -> void:
	if(!self.visible): return;
	
	draw_colored_polygon(cone_points, cone_color)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("camera_mode"):
		toggle_camera_mode()

func _process(delta: float) -> void:
	handle_mouse_input()
	handle_controller_input()
	
	if(!self.visible): return;
	
	# Smooth the rotation
	current_rotation = lerp_angle(current_rotation, target_rotation, rotation_speed * delta)
	check_obstacles()

func _physics_process(delta: float) -> void:
	if(!self.visible): return;
	
	clear_last_frames_hitobjects()
	update_timer += delta
	if update_timer >= 1.0 / update_frequency:
		update_timer = 0.0
		check_obstacles()

func get_current_objects_in_view() -> Array:
	var currentObjects: Array[CanvasGroup] = []
	for obj: Object in hit_objects:
		if obj is CanvasGroup:
			currentObjects.append(obj)
	
	return currentObjects

func toggle_camera_mode() -> void:
	self.visible = !self.visible

func clear_last_frames_hitobjects() -> void:
	# Clear previous frame's hit objects
	for obj: Object in hit_objects:
		if obj is CanvasGroup:
			obj.material.set_shader_parameter("line_thickness", 0.0)
	hit_objects.clear()

func update_cone_shape() -> void:
	cone_points = PackedVector2Array()
	cone_points.append(Vector2.ZERO)
	
	var angle_start := -cone_angle / 2
	var angle_end := cone_angle / 2
	
	for i in range(raycast_density + 1):
		var angle: float = deg_to_rad(lerp(angle_start, angle_end, float(i) / raycast_density))
		var point := Vector2(
			cos(angle) * cone_range,
			sin(angle) * cone_range
		)
		cone_points.append(point)
	
	queue_redraw() # ensure visual update

func check_obstacles() -> void:
	var space_state := get_world_2d().direct_space_state
	var updated_points := PackedVector2Array([Vector2.ZERO])
	var angle_start := -cone_angle / 2
	var angle_end := cone_angle / 2
	
	for i in range(raycast_density + 1):
		var base_angle: float = lerp(angle_start, angle_end, float(i) / raycast_density)
		var angle := deg_to_rad(base_angle) + current_rotation
		var ray_direction := Vector2( cos(angle) * cone_range, sin(angle) * cone_range * iso_y_scale	)
		
		var query := PhysicsRayQueryParameters2D.create( global_position, global_position + ray_direction )
		query.collision_mask = blocking_layers
		
		var result := space_state.intersect_ray(query)
		if result:
			var highlightNode : CanvasGroup = result.collider.find_child("Highlight")
			# Store hit object's CanvasGroup
			if highlightNode is CanvasGroup:
				var canvas_group := highlightNode
				if not hit_objects.has(highlightNode):
					hit_objects[canvas_group] = true
					canvas_group.material.set_shader_parameter("line_thickness", 4.0)
			
			if result.collider.collision_layer & pass_through_layers:
				updated_points.append(ray_direction)
			else:
				var local_collision: Vector2 = result.position - global_position
				updated_points.append(local_collision)
		else:
			updated_points.append(ray_direction)
	
	cone_points = updated_points
	queue_redraw()

func handle_mouse_input() -> void:
	if(!self.visible): return;
	
	# get angle with mouse input
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos := get_global_mouse_position()
		target_rotation = (mouse_pos - global_position).angle()

func handle_controller_input() -> void:
	if(!self.visible): return;
	
	# get angle with controller input
	var stick_input := Vector2(
		Input.get_axis("camera_left", "camera_right"),
		Input.get_axis("camera_up", "camera_down")
	)
	
	if stick_input.length() > 0.1:
		target_rotation = stick_input.angle()

func _on_hidden() -> void:
	clear_last_frames_hitobjects()
