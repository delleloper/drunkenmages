extends Area2D

enum potionType {
	JUMPER, TORNADO, BALL, SPLASHER
}
@export var potionClass : potionType
#@export var potion : PackedScene
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	var animrand = randf_range(0,animation_player.get_current_animation_length())

	animation_player.seek(animrand)
	if potionClass == null:
		queue_free()
	match potionClass:
		potionType.JUMPER:
			sprite_2d.modulate = Color.YELLOW
		potionType.JUMPER:
			sprite_2d.modulate = Color.NAVY_BLUE

func get_potion():
	match potionClass:
		potionType.JUMPER:
			return preload("res://Scenes/potions/jumper.tscn")
		potionType.SPLASHER:
			return preload("res://Scenes/potions/splasher.tscn")

func get_color():
	return Color.YELLOW

func _on_body_entered(body):
	if body is Player:
		body.pickPotion(get_potion(), get_color())
		queue_free()
