extends RigidBody2D

@onready var sprite_2d = $Sprite2D
@export var bounces : int = 10
@onready var bounce = $bounce
@onready var animation_player = $AnimationPlayer

func _on_area_2d_body_entered(body):
	if body.position.y < position.y:
		apply_impulse(Vector2(0,-50))
	bounces -= 1
	bounce.play(0)
	if bounces == 0:
		animation_player.play("exit")
