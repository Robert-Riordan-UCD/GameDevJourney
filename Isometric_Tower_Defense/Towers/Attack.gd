class_name Attack
extends Node2D

@onready var bullet = $Bullet

func attack(enemy: Enemy, damage: int) -> void:
	print("Attacking!!!")
	enemy.take_damage(damage)
	bullet.goto(enemy.position)
