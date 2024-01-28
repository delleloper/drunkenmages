extends Area2D

enum potionType {
	NONE, JUMPER, TORNADO, BALL, SPLASHER
}
@export var potionClass : potionType = potionType.NONE
#@export var potion : PackedScene
@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	var animrand = randf_range(0,animation_player.get_current_animation_length())
	animation_player.seek(animrand)
	if potionClass == potionType.NONE:
		potionClass = randi_range(1,3) 
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
			return Color("b201ef")
		potionType.SPLASHER:
			return Color("5fcde4")
		potionType.BALL:
			return Color("fa5a32")
		potionType.TORNADO:
			return Color("99e550")


func _on_body_entered(body):
	if body is Player:
		if body.currentPotion == null:
			body.pickPotion(get_potion(), get_color())
			queue_free()
