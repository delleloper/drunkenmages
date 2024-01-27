extends RigidBody2D

class_name Projectile

var direction


func addToscene(object):
	get_tree().current_scene.call_deferred("add_child",object)

func explode():
	pass
	#queue_free()

func _on_body_entered(_body):
	if !_body is Projectile:
		explode()
