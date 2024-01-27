extends Puddle
@export var multiplier = 5

func playerEnter(player):
	player.puddleJump(multiplier)
