extends Area2D

signal hit

func _ready():
	connect("body_entered", body_entered)
	
func body_entered(body):
	hit.emit()
