extends Node2D

signal enemy_reached_end(damage)
signal enemy_died(gold)

func _on_spawn_point_enemy_spawned(enemy: Enemy, pos: Vector2) -> void:
	add_child(enemy)
	enemy.position = pos
	enemy.reached_end.connect(_reached_end.bind())
	enemy.died.connect(_enemy_died.bind())

func _reached_end(damage: int) -> void:
	enemy_reached_end.emit(damage)

func _enemy_died(gold: int) -> void:
	enemy_died.emit(gold)
