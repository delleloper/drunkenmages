extends RigidBody2D

@onready var sprite_2d = $Sprite2D
@export var bounces : int = 10
	
func _on_area_2d_body_entered(body):
	if body.position.y < position.y:
		apply_impulse(Vector2(0,-50))
	bounces -= 1
	if bounces == 0:
		queue_free()
