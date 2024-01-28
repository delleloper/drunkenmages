extends RigidBody2D

class_name Puddle
@onready var animation_player = $AnimationPlayer

func playerEnter(_player):
	pass

func _on_puddle_body_entered(body):
	if body is Player:
		playerEnter(body)

func _on_puddle_area_entered(area):
	if area is Puddle:
		queue_free()


func _on_timer_timeout():
	animation_player.play("dissapear")
