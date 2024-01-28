extends Line2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var collsionTest : CharacterBody2D = $CharacterBody2D
var collided = false

func update_trajectory( dir: Vector2, speed: float, delta: float):
	var max_points =350
	clear_points()
	var pos : Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		var collision = collsionTest.move_and_collide(vel *delta, false, true, true)
		pos += vel * delta
		collsionTest.position = pos
		if collision:
			break
			
