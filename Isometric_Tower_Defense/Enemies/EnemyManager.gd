extends Node2D

signal enemy_reached_end(damage)
signal enemy_died(gold)
signal all_enemies_defeated

@onready var all_enemies_spawned: bool = false

func _on_spawn_point_enemy_spawned(enemy: Enemy, pos: Vector2) -> void:
	add_child(enemy)
	enemy.position = pos
	enemy.reached_end.connect(_reached_end.bind())
	enemy.died.connect(_enemy_died.bind())

func _reached_end(damage: int) -> void:
	enemy_reached_end.emit(damage)
	check_win()

func _enemy_died(gold: int) -> void:
	enemy_died.emit(gold)
	check_win()

func _on_spawn_point_all_enemies_spawned():
	all_enemies_spawned = true

func check_win():
	await get_tree().process_frame
	if !all_enemies_spawned: return
	for c in get_children():
		if c is Enemy and c.dead == false:
			return
	all_enemies_defeated.emit()
