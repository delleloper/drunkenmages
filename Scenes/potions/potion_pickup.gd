extends Area2D

@export var potion : PackedScene

func _ready():
	if potion == null:
		queue_free()

func _on_body_entered(body):
	if body is Player:
		body.pickPotion(potion)
		queue_free()
