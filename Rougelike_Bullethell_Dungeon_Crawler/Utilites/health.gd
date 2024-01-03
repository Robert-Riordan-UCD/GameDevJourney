class_name Health
extends Node2D

signal damaged
signal died

@export var max_health:float = 100

@onready var current_health:float = max_health

func take_damage(damage:float) -> void:
	assert(damage >= 0)
	print("Taking damage! ", damage)
	current_health -= damage
	print("Current health: ", current_health)
	if current_health <= 0:
		died.emit()
		print("I'm dead :(")
	else:
		damaged.emit()
