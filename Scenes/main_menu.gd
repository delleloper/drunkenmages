extends Control

var count = 2
var readyForinput = false
@onready var animation_player = $AnimationPlayer


func _ready():
	Engine.time_scale = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ready:
		if Input.is_action_pressed("throw1") && Input.is_action_pressed("throw2"):
			count-= delta
		if count <= 0:
			get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")


func _on_timer_timeout():
	readyForinput = true
	animation_player.play("init")
