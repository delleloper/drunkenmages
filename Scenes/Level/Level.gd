extends Node2D
@onready var camera_2d = $Camera2D
@export var camera_speed = 0

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_tree().reload_current_scene()
	camera_2d.position.y -= camera_speed * delta 
