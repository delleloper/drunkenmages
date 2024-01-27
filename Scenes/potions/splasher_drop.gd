extends "res://scripts/projectile.gd"

const PUDDLE = preload("res://Scenes/potions/puddle.tscn")

func explode():
	var puddle = PUDDLE.instantiate()
	puddle.global_position = global_position
	addToscene(puddle)
	queue_free()
