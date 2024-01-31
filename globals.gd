extends Node

func playRandomSound(player: AudioStreamPlayer, array : Array):
	array.shuffle()
	player.stream = array[0]
	player.play();
func stopSound(player: AudioStreamPlayer):
	player.stop();

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("mute"):
		if AudioServer.is_bus_mute(0):
			AudioServer.set_bus_mute(0, false)
		else:
			AudioServer.set_bus_mute(0, true)

