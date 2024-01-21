class_name Health
extends Node2D

signal damaged
signal died
signal healed

@export var max_health:float = 100

@onready var current_health:float = max_health

func take_damage(damage:float, crit:bool=false) -> void:
	assert(damage >= 0)
	current_health -= damage
	DamageNumbers.display_number(damage, global_position, crit)
	if current_health <= 0:
		died.emit()
	else:
		damaged.emit()

func heal(amount:float) -> void:
	current_health = min(max_health, current_health+amount)
	healed.emit()
	print("healing")
