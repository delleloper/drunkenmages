extends Area2D
var picked = false

func _on_body_entered(body):
	if !picked:
		picked = true
		owner.victory(body.number)
		body.altered_state = body.Altered_State.WIN
		visible = false
		owner.cameraShake()
