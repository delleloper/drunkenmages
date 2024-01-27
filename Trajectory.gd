extends Line2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func update_trajectory( dir: Vector2, speed: float, delta: float):
	var max_points =100
	clear_points()
	var pos : Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
