extends Node2D


func _on_spawn_point_enemy_spawned(enemy, pos):
	add_child(enemy)
	enemy.position = pos
