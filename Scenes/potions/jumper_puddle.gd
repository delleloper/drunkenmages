extends Puddle
@export var multiplier = 5

func playerEnter(player):
	animation_player.play("jump")
	player.puddleJump(multiplier)
