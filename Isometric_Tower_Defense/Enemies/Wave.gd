class_name Wave
extends Node

signal spawn_unit(unit)
signal wave_complete

@export_category("Units")
@export var wave_units : Array[EnemyTypes]

@export_category("Wave")
@export var wait_between_units : float = 0.5

enum EnemyTypes {Orc, Wolf}
var orc_scene := preload("res://Enemies/Orc.tscn")
var wolf_scene := preload("res://Enemies/Wolf.tscn")

func _ready():
	$Timer.wait_time = wait_between_units

func start():
	$Timer.start()

func _on_timer_timeout():
	match(wave_units[0]):
		EnemyTypes.Orc: spawn_unit.emit(orc_scene)
		EnemyTypes.Wolf: spawn_unit.emit(wolf_scene)
	wave_units.pop_front()
	if wave_units.size() <= 0:
		wave_complete.emit()
		queue_free()
