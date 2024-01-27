extends Potion

const SPLASHER_DROP = preload("res://Scenes/potions/splasher_drop.tscn")

@export var amount : int = 3
@export var speed : float = 5500
@export var spread : float = 1500

func explode():
	for each in amount:
		spawn_drop()
	queue_free()

func spawn_drop():
	var drop = SPLASHER_DROP.instantiate() as RigidBody2D
	drop.global_position = global_position
	addToscene(drop)
	var dropVelocity = Vector2(randf_range(-spread, spread) * randf() , -1 * speed)
	drop.apply_central_impulse(dropVelocity)
