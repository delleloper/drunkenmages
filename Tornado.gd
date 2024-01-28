extends CharacterBody2D

var direction : Vector2
@export var speed : int = 100
@onready var change_direction = $changeDirection
@onready var tornado_victim = $TornadoVictim

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if randf() > 0.5:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT
	change_direction.start(randf_range(1, 5))
	

func _physics_process(delta):
	velocity = velocity.move_toward(direction * speed,delta * 20)
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	move_and_slide()


func _on_timer_timeout():
	pass # Replace with function body.


func _on_change_direction_timeout():
	direction = direction * -1
	change_direction.start(randf_range(1, 2))
	

func _on_area_2d_body_entered(body):
	if body is Player:
		body.enterTornado()
		tornado_victim.visible = true
