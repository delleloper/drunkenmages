extends Node2D

@onready var camera_2d = $Camera2D
@export var camera_speed = 0
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
	for each in players:
		each.dead.connect(game_over)

func game_over():
	get_tree().reload_current_scene()
	
