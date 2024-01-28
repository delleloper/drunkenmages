extends CharacterBody2D

var direction : Vector2
@export var speed : int = 100
@onready var change_direction = $changeDirection
@onready var tornado_victim = $TornadoVictim
@onready var timer = $Timer
@onready var tornado_exit = $TornadoExit

var is_player_affected = false
var player_affected : Player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if randf() > 0.5:
		direction = Vector2.LEFT
	else:
		direction = Vector2.RIGHT
	change_direction.start(randf_range(1, 5))
	timer.start(8)

func _physics_process(delta):
	velocity = velocity.move_toward(direction * speed,delta * 20)
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	move_and_slide()


func _on_timer_timeout():
	if is_player_affected:
		player_affected.exitTornado(global_position)
	queue_free()


func _on_change_direction_timeout():
	direction = direction * -1
	change_direction.start(randf_range(1, 2))
	

func _on_area_2d_body_entered(body):
	if body is Player && !player_affected:
		tornado_exit.start(3)
		body.enterTornado()
		player_affected = body
		is_player_affected = true
		tornado_victim.visible = true

func _on_tornado_exit_timeout():
	if player_affected != null:
		player_affected.exitTornado(global_position)
	is_player_affected = false
	player_affected = null
	tornado_victim.visible = false
	queue_free()
