extends Node2D

var throwing = true
var throwDirection = Vector2.ZERO
#TODO change current in player script
@export var currentPotion : PackedScene
@export var throw_speed : int
var throwInput : String
var move_left :String 
var move_right : String
var jump : String
var throw : String
@onready var player : Player = owner  
@onready var line_2d = $Line2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	throwing = Input.is_action_pressed(player.throw)
	if throwing:
		throwDirection = Input.get_vector(player.move_left, player.move_right, player.move_up, player.move_down)
	#print(throwDirection)
		line_2d.update_trajectory(throwDirection,throw_speed,_delta)
	line_2d.visible = throwing && !throwDirection.is_zero_approx()
	
func _input(_event):
	if currentPotion == null:
		print("NO POTION")
		return
	if Input.is_action_just_released(player.throw) && !throwDirection.is_equal_approx(Vector2.ZERO):
		throwProjectile()

func throwProjectile():
	var throwable : RigidBody2D = currentPotion.instantiate()
	throwable.apply_central_impulse(throwDirection * throw_speed)
	throwable.global_position = global_position
	get_tree().current_scene.add_child(throwable)
	
