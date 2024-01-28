extends Camera2D

@export var randomStrength :float = 30.0 
@export var shakeFade : float = 5.0

var rng = RandomNumberGenerator.new()

var shakeStrength : float = 0.0

func applyShake():
	shakeStrength = randomStrength

func _process(delta):
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0, shakeFade * delta)
		offset = randomOffset()

func randomOffset():
	return Vector2(rng.randf_range(-shakeStrength,shakeStrength),rng.randf_range(-shakeStrength,shakeStrength))
