extends Potion

const PUDDLE = preload("res://Scenes/potions/splasher_puddle.tscn")

func explode():
	var puddle = PUDDLE.instantiate()
	puddle.global_position = global_position
	addToscene(puddle)
	queue_free()
