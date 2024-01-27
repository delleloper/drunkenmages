extends Node2D

var throwing = true
var throwDirection = Vector2.ZERO
const PROJECTILE = preload("res://projectile.tscn")
@export var throw_speed : int
@onready var icon = $Icon


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	throwing = Input.is_action_pressed("throw")
	if throwing:
		throwDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	print(throwDirection)
	
func _input(event):
	if Input.is_action_just_released("throw") && !throwDirection.is_equal_approx(Vector2.ZERO):
		throwProjectile()

func throwProjectile():
	var throwable : RigidBody2D = PROJECTILE.instantiate()
	throwable.apply_central_impulse(throwDirection * throw_speed)
	add_child(throwable)
	
