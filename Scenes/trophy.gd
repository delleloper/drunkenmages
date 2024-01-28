extends Area2D
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	owner.victory()
	body.altered_state = body.Altered_State.WIN
	visible = false
	owner.cameraShake()

func change():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
