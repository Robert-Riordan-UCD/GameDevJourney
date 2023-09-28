extends Node2D

signal enemy_spawned(enemy, position)

var orc_scene := preload("res://Enemies/Orc.tscn")
var first_spawn := true

func spawn_orc() -> void:
	var new_orc :Node2D= orc_scene.instantiate()
	new_orc.scale *= 0.15
	emit_signal("enemy_spawned", new_orc, position)

func _on_timer_timeout():
	spawn_orc()
