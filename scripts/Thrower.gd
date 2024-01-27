extends Node2D

var throwing = true
var throwDirection = Vector2.ZERO
#TODO change current in player script
@export var currentPotion : PackedScene
@export var throw_speed : int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	throwing = Input.is_action_pressed("throw")
	if throwing:
		throwDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#print(throwDirection)
	
func _input(_event):
	if Input.is_action_just_released("throw") && !throwDirection.is_equal_approx(Vector2.ZERO):
		throwProjectile()

func throwProjectile():
	var throwable : RigidBody2D = currentPotion.instantiate()
	throwable.apply_central_impulse(throwDirection * throw_speed)
	throwable.global_position = global_position
	get_tree().current_scene.add_child(throwable)
	
