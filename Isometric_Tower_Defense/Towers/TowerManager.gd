class_name TowerManager
extends Node2D

@export var level_manager : LevelManager
@export var ground_tile_map : TileMap

var tower_scene := preload("res://Towers/Tower.tscn")
var crossbow_tower_scene := preload("res://Towers/CrossbowTower.tscn")

func _input(event):
	if event.is_action_pressed("left_mouse"):
		if ground_tile_map.can_place_tower(get_global_mouse_position()):
			var new_tower : Tower = crossbow_tower_scene.instantiate()
			if randf() > .5:
				new_tower = tower_scene.instantiate()
			if !level_manager.spend_gold(new_tower.price):
				return
			add_child(new_tower)
			new_tower.position = ground_tile_map.snap_to_grid(get_global_mouse_position())
			new_tower.request_level_up.connect(_request_level_up.bind(new_tower))

func _request_level_up(cost: int, tower: Tower) -> void:
	if !level_manager.spend_gold(cost):
		return
	tower.level_up()
