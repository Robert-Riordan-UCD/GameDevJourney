class_name Attack
extends Node2D

func attack(enemy: Enemy, damage: int) -> void:
	enemy.take_damage(damage)
