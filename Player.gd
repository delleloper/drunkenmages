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
	HIT,
	SLIDING,
	SPINNING,
	WIN
}

@export_category("Default Stats")
@export var speed : float = 120.0
var current_speed : float
@export_range(0.0, 10.0) var acceleration : int = 1
var current_acceleration : int
@export_range(0.0, 10.0) var friction : int = 1
var current_friction : float
@export var jump_velocity : float = 150.0
var current_jump_velocity : float

var flip = false
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
@export_category("Sounds")
@export var ballHitSounds : Array[AudioStream]
@export var playerSlideSounds : Array[AudioStream]
@export var playerJumpSounds : Array[AudioStream]
@export var playerSpinSounds : Array[AudioStream]
@export var playerMineSounds : Array[AudioStream]
@export var playerFallSounds : Array[AudioStream]

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite
@onready var thrower = $Thrower
@onready var potion_sprite : Sprite2D = $Potion_sprite
@onready var collision_shape_2d = $CollisionShape2D
@onready var collider_timer = $collider_timer
@export var number : int

var currentPotion : PackedScene
var currentPotionColor : Color
var onCooldown = false

signal dead(number)
signal shake


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
	#var push = 100
	#for index in get_slide_collision_count():
		#var collision : KinematicCollisio2D = get_slide_collision(index)
		#var col = collision.get_collider()
		#if not col is TileMap:
			#print(collision, col)
		#if col.is_in_group("bodies"):
			#print("collide")
			#col.apply_central_impulse(-collision.get_normal() * push)
	
func handle_inputs() -> void:
	if !Input.is_action_pressed(throw):
		direction = Input.get_axis(move_left, move_right)
	else:
		direction = Vector2.ZERO
	if Input.is_action_just_pressed(jump) and is_on_floor():
		if Input.is_action_pressed(move_down):
			collision_shape_2d.disabled = true
			collider_timer.start(.1)
		else:
			velocity.y = -current_jump_velocity
			Globals.playRandomSound($playerJump, playerJumpSounds)
			
func handle_movement(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction:
		velocity.x = lerp(velocity.x, direction * current_speed, current_acceleration * LERP_MULTIPLIER)
	else:
		velocity.x = lerp(velocity.x, 0.0, current_friction * LERP_MULTIPLIER)
		if velocity.x < 3 && velocity.x > -3:
			velocity.x = 0
	if abs(velocity.x) < 20 && abs(velocity.y) < 3 && (altered_state == Altered_State.ROLLING || altered_state == Altered_State.SLIDING || altered_state == Altered_State.HIT):
		altered_state = Altered_State.NONE
		current_friction = friction
	if altered_state == Altered_State.ROLLING:
		current_friction = 2
	#if velocity.y > 350:
		#Globals.playRandomSound($playerFall, playerFallSounds)
	#if is_on_floor() && $playerFall.playing:
		#Globals.stopSound($playerFall)
		
func handle_animations() -> void:
	match altered_state:
		Altered_State.NONE:
			thrower.enabled = true			
			if velocity.y > 3 && !is_on_floor():
				animation_player.play("Fall")
				side_potion()
			if velocity.x != 0 && is_on_floor():
				animation_player.play("Walk")
				side_potion()
			if velocity.y < 0:
				animation_player.play("Jump")
				side_potion()
			if velocity == Vector2.ZERO:
				animation_player.play("Idle")
				hide_potion()
			if Input.is_action_pressed(throw):
				animation_player.play("Cast")
				center_potion()
		Altered_State.ROLLING:
			animation_player.play("Roll")
			hide_potion()
			thrower.enabled = false
		Altered_State.HIT:
			animation_player.play("Stunned")
			hide_potion()
		Altered_State.SLIDING:
			animation_player.play("Slide")
			hide_potion()
		Altered_State.WIN:
			animation_player.play("Winner")
			velocity = Vector2.ZERO
	
	if velocity.x < 0:
		sprite.flip_h = true
	if velocity.x > 0:
		sprite.flip_h = false


	
func hide_potion():
	potion_sprite.visible = false
func side_potion():
	if currentPotion:
		potion_sprite.visible = true
		potion_sprite.modulate = currentPotionColor
		potion_sprite.position.x = 12 if sprite.flip_h else -12
		potion_sprite.position.y = -15
	else:
		potion_sprite.visible = false
func center_potion():
	if currentPotion:
		potion_sprite.visible = true
		potion_sprite.modulate = currentPotionColor
		potion_sprite.position.x = 0
		potion_sprite.position.y = -25
		
func puddleJump(multiplier):
	if velocity.y >= 0:
		shake.emit()
		direction = Vector2.ZERO
		current_friction = current_friction * 0.3
		velocity.y = clamp(velocity.y * -1 * multiplier, -500, 500)
		velocity.x = velocity.x * multiplier * (-1 if is_on_floor() else 1)
		altered_state = Altered_State.ROLLING
		Globals.playRandomSound($playerMine, playerMineSounds)
		if velocity.is_zero_approx():
			velocity.y = -500

func puddleSlide(multiplier):
	if velocity.y >= 0:
		direction = Vector2.ZERO
		current_friction = current_friction * 0.55
		velocity.x = velocity.x * multiplier
		altered_state = Altered_State.SLIDING
		Globals.playRandomSound($playerSlide, playerSlideSounds)
		if velocity.is_zero_approx():
			velocity.x = 500 * (-1 if position.x < 240 else 1)
				
func pickPotion(potion, color):
	$grabpotion.play()
	currentPotion = potion
	currentPotionColor = color

func _on_visible_on_screen_notifier_2d_screen_exited():
	if visible:
		dead.emit(number)

func enterTornado():
	#visible
	#motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	visible = false
	thrower.enabled = false
	altered_state = Altered_State.SPINNING
	Globals.playRandomSound($playerSpin, playerSpinSounds)

func exitTornado(position):
	global_position = position
	position.y -= 50
	visible = true
	altered_state = Altered_State.ROLLING
	velocity = Vector2(randf_range(-2,2) * 300, -500)
	current_friction = 3
	shake.emit()
	thrower.enabled = true
	
	
func _on_area_2d_body_entered(body):
	if body is Player && altered_state != Altered_State.NONE:
		player_bounce(1)
		
func _on_area_2d_2_body_entered_2(body):
	if body is Player && altered_state != Altered_State.NONE:
		player_bounce(-1)


func player_bounce(dir):
	shake.emit()	
	velocity.x = 100 * dir
	current_friction += 3


func _on_area_2d_body_entered_projectiles(body):
	if body is RigidBody2D:
		playerHit(body)

func playerHit( throwable: RigidBody2D):
	if throwable is Potion:
		if throwable.player.number == number:
			return
	
	if throwable.position.x > position.x:
		velocity.x = -300
		throwable.apply_impulse(Vector2(150,0))
	else:
		velocity.x = 300
		throwable.apply_impulse(Vector2(-150,0))
	altered_state = Altered_State.HIT
	Globals.playRandomSound($playerHit, ballHitSounds)
	shake.emit()


func set_color(color : Color):
	sprite.modulate = color

func _on_collider_timer_timeout():
	collision_shape_2d.disabled = false
