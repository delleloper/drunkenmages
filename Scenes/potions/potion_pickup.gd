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
		potionType.keys()[randi() % potionType.size()]
	sprite_2d.modulate = get_color()

func get_potion():
	match potionClass:
		potionType.JUMPER:
			return preload("res://Scenes/potions/jumper.tscn")
		potionType.SPLASHER:
			return preload("res://Scenes/potions/splasher.tscn")
		potionType.BALL:
			return preload("res://Scenes/potions/firepotion.tscn")
		potionType.TORNADO:
			return preload("res://Scenes/potions/tornadopotion.tscn")

func get_color():
	match potionClass:
		potionType.JUMPER:
			return Color.YELLOW
		potionType.SPLASHER:
			return Color.NAVY_BLUE
		potionType.BALL:
			return Color.RED
		potionType.TORNADO:
			return Color.GREEN


func _on_body_entered(body):
	if body is Player:
		if body.currentPotion == null:
			body.pickPotion(get_potion(), get_color())
			queue_free()
