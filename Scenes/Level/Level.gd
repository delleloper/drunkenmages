extends Node2D
@onready var reset_timer = $ResetTimer

@onready var camera_2d = $Camera2D
@export var camera_speed = 0
@export var player2Color :Color
@onready var label = $Control/Label

var players : Array
func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()

func _on_area_2d_body_entered(body):
	if body is Player:
		var tween = create_tween()
		tween.tween_property(camera_2d,"position", camera_2d.position + (Vector2.UP * 100),1)

func _ready():
	players = get_tree().get_nodes_in_group("player")
	players[1].set_color(player2Color)
	for each in players:
		each.dead.connect(game_over)
		each.shake.connect(cameraShake)

func game_over(player_number):
	reset_timer.start(3) 

func cameraShake():
	camera_2d.applyShake()

func _on_reset_timer_timeout():
	get_tree().reload_current_scene()
@onready var animation_player = $Control/AnimationPlayer

func victory(number: int):
	Engine.time_scale = 0.5
	label.text.replace("X",number)
	animation_player.play("victory")
	
