extends Area2D

enum potionType {
	JUMPER, TORNADO, BALL, SPLASHER
}
@export var potionClass : potionType
#@export var potion : PackedScene
@onready var sprite_2d = $Sprite2D

func _ready():
	if potionClass == null:
		queue_free()
	match potionClass:
		potionType.JUMPER:
			sprite_2d.modulate = Color.YELLOW

func get_potion():
	match potionClass:
		potionType.JUMPER:
			return preload("res://Scenes/potions/jumper.tscn")

func _on_body_entered(body):
	if body is Player:
		body.pickPotion(get_potion())
		queue_free()
