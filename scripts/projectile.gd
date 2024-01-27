extends RigidBody2D

class_name Potion

var direction
@onready var sprite_2d = $Sprite2D
var rotation_speed = 360
@onready var particles = $GPUParticles2D

func addToscene(object):
	get_tree().current_scene.call_deferred("add_child",object)

func _process(delta):
	sprite_2d.rotation_degrees = sprite_2d.rotation_degrees+(delta*rotation_speed)

func explode():
	remove_child(particles)
	particles.global_position = global_position
	get_parent().add_child(particles)
	particles.emitting = false
	#queue_free()

func _on_body_entered(body):
	if body is Puddle:
		queue_free()
	if !body is Potion:
		explode()
		return
