class_name Health
extends Node2D

signal damaged
signal died

@export var max_health:float = 100

@onready var current_health:float = max_health

func take_damage(damage:float) -> void:
	assert(damage >= 0)
	current_health -= damage
	if current_health <= 0:
		died.emit()
	else:
		damaged.emit()
