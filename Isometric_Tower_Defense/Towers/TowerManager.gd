extends Node2D

@export var level_manager : LevelManager
@export var ground_tile_map : TileMap

var tower_scene := preload("res://Towers/Tower.tscn")

func _input(event):
	if event.is_action_pressed("left_mouse"):
		if ground_tile_map.can_place_tower(get_global_mouse_position()):
			var new_tower : Tower = tower_scene.instantiate()
			if !level_manager.spend_gold(new_tower.price): return
			add_child(new_tower)
			new_tower.position = ground_tile_map.snap_to_grid(get_global_mouse_position())
