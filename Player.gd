extends CharacterBody2D

class_name Player

enum Drunken_Status{
	SOBER,
	LIGHTLY_DRUNKEN,
	MIDLY_DRUNKEN,
	HEAVILY_DRUNKEN
	}
enum Altered_State{
	NONE,
	ROLLING,
	HIT
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
@export_category("Status")
@export var drunken_status : Drunken_Status
@export var altered_state : Altered_State
@export_category("Inputs")
@export var move_left :String = "move_left"
@export var move_right : String = "move_right"
@export var move_up :String = "move_up"
@export var move_down : String = "move_down"
@export var jump : String = "jump"
@export var throw : String = "throw"
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite
@onready var thrower = $Thrower


func _ready():
	current_acceleration = acceleration
	current_friction = friction
	current_speed = speed
	current_jump_velocity = jump_velocity
	drunken_status = Drunken_Status.SOBER
	altered_state = Altered_State.NONE
	animation_player.play("Idle")
	
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):	
	if altered_state == Altered_State.NONE:
		handle_inputs()
	handle_movement(delta)
	handle_animations()
	move_and_slide()
	
func handle_inputs() -> void:
	if !Input.is_action_pressed(throw):
		direction = Input.get_axis(move_left, move_right)
	else:
		direction = Vector2.ZERO
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = -current_jump_velocity
		
func handle_movement(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction:
		velocity.x = lerp(velocity.x, direction * current_speed, current_acceleration * LERP_MULTIPLIER)
	else:
		velocity.x = lerp(velocity.x, 0.0, current_friction * LERP_MULTIPLIER)
		if velocity.x < 3 && velocity.x > -3:
			velocity.x = 0
	if abs(velocity.x) < 20 && abs(velocity.y) < 3 && altered_state == Altered_State.ROLLING:
		altered_state = Altered_State.NONE
		current_friction = friction
		
func handle_animations() -> void:
	match altered_state:
		Altered_State.NONE:
			thrower.enabled = true			
			if velocity.y > 3 && !is_on_floor():
				animation_player.play("Fall")
			if velocity.x != 0 && is_on_floor():
				animation_player.play("Walk")
			if velocity.y < 0:
				animation_player.play("Jump")
			if velocity == Vector2.ZERO:
				animation_player.play("Idle")
		Altered_State.ROLLING:
			animation_player.play("Roll")
			thrower.enabled = false
		Altered_State.HIT:
			animation_player.play("Hit")
	
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false

func puddleJump(multiplier):
	if velocity.y >= 0:
		direction = Vector2.ZERO
		current_friction = current_friction * 0.3
		velocity.y = clamp(velocity.y * -1 * multiplier, -500, 500)
		velocity.x = velocity.x * multiplier * (-1 if is_on_floor() else 1)
		altered_state = Altered_State.ROLLING
	
func pickPotion(potion):
	thrower.currentPotion = potion
