extends Potion

const TORNADO = preload("res://Scenes/potions/tornado.tscn")

func explode():
	var tornado = TORNADO.instantiate()
	tornado.global_position = global_position
	addToscene(tornado)
	queue_free()
	super()
