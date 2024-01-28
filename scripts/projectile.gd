extends RigidBody2D

class_name Potion

var direction
@onready var sprite_2d = $Sprite2D
var rotation_speed = 360
@onready var particles = $GPUParticles2D
@export var color : Color
var exploded = false

func _ready():
	sprite_2d.modulate = color
	particles.modulate = color

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
		if(!exploded):
			exploded = true
			explode()
		return
