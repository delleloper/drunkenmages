extends RigidBody2D

const PUDDLE = preload("res://Scenes/potions/splasher_puddle.tscn")

func explode():
	var puddle = PUDDLE.instantiate()
	puddle.global_position = global_position
	get_tree().current_scene.call_deferred("add_child",puddle)
	queue_free()

func _on_body_entered(body):
	if body is Puddle:
		queue_free()
	if !body is Potion:
		explode()
		return
