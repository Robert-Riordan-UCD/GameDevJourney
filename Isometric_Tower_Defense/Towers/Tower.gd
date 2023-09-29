class_name Tower
extends Area2D

@export var price : int = 50

@export_category("Attack")
@export var range : float = 300
@export var damage : int = 1
@export var cooldown : float = 0.5

@onready var range_shape = $Range
@onready var attack_timer = $AttackTimer

var enemies : Array = []

func _ready():
	range_shape.scale *= range
	attack_timer.wait_time = cooldown

func _on_area_entered(area):
	if area is Enemy:
		enemies.append(area)
		print("Orcs!")

func _on_attack_timer_timeout():
	for i in range(len(enemies)-1, 0, -1):
		if enemies[i] == null:
			enemies.remove_at(i)
		else:
			var dead : bool = enemies[i].take_damage(damage)
			if dead:
				enemies.remove_at(i)
			break
