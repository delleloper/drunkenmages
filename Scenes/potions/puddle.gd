extends RigidBody2D

class_name Puddle

func playerEnter(_player):
	pass

func _on_puddle_body_entered(body):
	if body is Player:
		playerEnter(body)
