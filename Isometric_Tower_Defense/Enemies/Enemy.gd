extends Node2D

@export var speed : float = 10

func _process(delta):
	position.x -= delta*speed
