extends CharacterBody3D

@export var max_speed: float = 10.0
@export var acceleration: float = 70.0
@export var friction: float = 60.0
@export var air_friction: float = 10.0
@export var gravity: float = -40.0
@export var jump_impulse: float = 20.0
@export var mouse_sensitivity: float = 0.1
@export var controller_sensitivity: float = 3.0
@export var rot_speed: float = 5.0
@export_range(0, 10) var push: int = 1

var snap_vector: Vector3 = Vector3.ZERO

@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	get_tree().create_timer(10)
	Engine.max_fps = 144
	Engine.physics_ticks_per_second = 144
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))

func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_movement(input_vector, direction, delta)
	apply_friction(direction, delta)
	apply_gravity(delta)
	update_snap_vector()
	jump()
	#apply_controller_rotation()

	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-75), deg_to_rad(75))

	move_and_slide()

func get_input_vector() -> Vector3:
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector

func get_direction(input_vector: Vector3) -> Vector3:
	var direction = (input_vector.x * transform.basis.x) + (input_vector.z * transform.basis.z)
	return direction

func apply_movement(input_vector: Vector3, direction: Vector3, delta: float) -> void:
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
		pivot.rotation.y = lerp_angle(pivot.rotation.y, atan2(-input_vector.x, -input_vector.z), rot_speed * delta)

func apply_friction(direction: Vector3, delta: float) -> void:
	if direction == Vector3.ZERO:
		if is_on_floor():
			velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		else:
			velocity.x = velocity.move_toward(Vector3.ZERO, air_friction * delta).x
			velocity.z = velocity.move_toward(Vector3.ZERO, air_friction * delta).z

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, gravity, jump_impulse)

func update_snap_vector() -> void:
	snap_vector = -get_floor_normal() if is_on_floor() else Vector3.DOWN

func jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		snap_vector = Vector3.ZERO
		velocity.y = jump_impulse
	if Input.is_action_just_released("ui_accept") and velocity.y > jump_impulse / 2:
		velocity.y = jump_impulse / 2

#func apply_controller_rotation() -> void:
	#var axis_vector = Vector2.ZERO
	#axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	#axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	#
	#if axis_vector != Vector2.ZERO:
		#rotate_y(deg_to_rad(-axis_vector.x) * controller_sensitivity)
		#camera.rotate_x(deg_to_rad(-axis_vector.y) * controller_sensitivity)

func _on_fov_updated(value: float) -> void:
	camera.fov = value

func _on_mouse_sens_updated(value: float) -> void:
	mouse_sensitivity = value
