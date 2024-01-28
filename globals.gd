extends Node

func playRandomSound(player: AudioStreamPlayer, array : Array):
	array.shuffle()
	player.stream = array[0]
	player.play();
func stopSound(player: AudioStreamPlayer):
	player.stop();
