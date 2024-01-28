extends Node2D

var throwing = true
var throwDirection = Vector2.ZERO
#TODO change current in player script
@export var throw_speed : int
@onready var player : Player = owner  
@onready var line_2d = $Line2D
var enabled = true
@onready var breakSound = $break
@export var throwSounds : Array[AudioStream]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player.currentPotion == null:
		return
	if !enabled:
		return

	throwing = Input.is_action_pressed(player.throw)
	if throwing && player.currentPotion:
		throwDirection = Input.get_vector(player.move_left, player.move_right, player.move_up, player.move_down)
		line_2d.update_trajectory(throwDirection,throw_speed,_delta)
	line_2d.visible = throwing && !throwDirection.is_zero_approx()
	if Input.is_action_just_released(player.throw) && !throwDirection.is_equal_approx(Vector2.ZERO):
		throwProjectile()


func throwProjectile():
	var throwable : RigidBody2D = player.currentPotion.instantiate()
	throwable.apply_central_impulse(throwDirection * throw_speed)
	throwable.global_position = global_position
	throwable.direction = throwDirection 
	get_tree().current_scene.add_child(throwable)
	player.currentPotion = null
	line_2d.clear_points()
	Globals.playRandomSound($throw,throwSounds)
	
	throwable.tree_exited.connect(func(): breakSound.play())
	
