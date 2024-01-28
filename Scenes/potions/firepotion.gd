extends Potion
const BALL = preload("res://Scenes/potions/ball.tscn")

func explode():
	var ball = BALL.instantiate()
	ball.position = global_position 
	addToscene(ball)
	queue_free()
	super()
