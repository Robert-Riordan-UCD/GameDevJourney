extends Node2D

signal enemy_reached_end(damage)

func _on_spawn_point_enemy_spawned(enemy: Enemy, pos: Vector2) -> void:
	add_child(enemy)
	enemy.position = pos
	enemy.reached_end.connect(_reached_end.bind())

func _reached_end(damage: int) -> void:
	enemy_reached_end.emit(damage)
