extends Potion
const BALL = preload("res://Scenes/potions/ball.tscn")

func explode():
	var ball = BALL.instantiate()
	ball.global_position = global_position 
	addToscene(ball)
	ball.apply_central_impulse(direction * 100)
	super()
	queue_free()
