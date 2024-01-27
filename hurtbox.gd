extends Area2D

signal damaged

func _ready():
	connect("body_entered", body_entered)
	
func body_entered(body):
	damaged.emit()
