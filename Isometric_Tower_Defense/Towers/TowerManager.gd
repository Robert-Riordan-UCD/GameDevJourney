extends Node2D

var tower_scene := preload("res://Towers/Tower.tscn")

func _input(event):
	if event.is_action_pressed("left_mouse"):
		var new_tower : Tower = tower_scene.instantiate()
		add_child(new_tower)
		new_tower.position = get_global_mouse_position()
