extends CharacterBody2D

enum Drunken_Status{
	SOBER,
	LIGHTLY_DRUNKEN,
	MIDLY_DRUNKEN,
	HEAVILY_DRUNKEN
	}


@export_category("Default Stats")
@export var speed : float = 120.0
var current_speed : float
@export_range(0.0, 10.0) var acceleration : int = 1
var current_acceleration : int
@export_range(0.0, 10.0) var friction : int = 1
var current_friction : int
@export var jump_velocity : float = 150.0
var current_jump_velocity : float
var direction
var throwing = false
const LERP_MULTIPLIER = 0.01


func _ready():
	current_acceleration = acceleration
	current_friction = friction
	current_speed = speed
	current_jump_velocity = jump_velocity

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	throwing = Input.is_action_pressed("throw")
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -current_jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if !throwing:
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = Vector2.ZERO
	
	if direction:
		velocity.x = lerp(velocity.x, direction * current_speed, current_acceleration * LERP_MULTIPLIER)
	else:
		velocity.x = lerp(velocity.x, 0.0, current_friction * LERP_MULTIPLIER)

	move_and_slide()
