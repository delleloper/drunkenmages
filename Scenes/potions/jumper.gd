extends Potion

const PUDDLE = preload("res://Scenes/potions/jumper_puddle.tscn")

func explode():
	var puddle = PUDDLE.instantiate()
	puddle.global_position = global_position
	addToscene(puddle)
	super()
	queue_free()
