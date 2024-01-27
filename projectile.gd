extends RigidBody2D

var direction

func explode():
	print("HIT")
	queue_free()

func _on_body_entered(body):
	explode()
