extends Control

var count = 2
@onready var animation_player = $AnimationPlayer

func _ready():
	if Time.get_ticks_msec() > 5000:
		animation_player.seek(2)
	Engine.time_scale = 1

func _process(delta):
	if Input.is_action_pressed("throw1") && Input.is_action_pressed("throw2"):
		count-= delta
	if count <= 0:
		get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")
	if Input.is_action_just_pressed("credits"):
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")


#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#animation_player.play("idle")
