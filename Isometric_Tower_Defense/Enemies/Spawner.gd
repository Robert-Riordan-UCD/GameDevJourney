extends Node2D

signal enemy_spawned(enemy, position)
signal all_enemies_spawned
signal new_wave(wave_number)

@export var path : Node2D

@export_category("Waves")
@export var wait_between_units : float = 0.5
@export var wait_between_waves : float = 10
@export var wave_units : Array = []

@onready var unit_timer = $UnitTimer
@onready var wave_timer = $WaveTimer

@onready var current_wave : int = 1

var orc_scene := preload("res://Enemies/Orc.tscn")
var first_spawn := true

func _ready() -> void:
	unit_timer.wait_time = wait_between_units
	wave_timer.wait_time = wait_between_waves
	unit_timer.start()
	new_wave.emit(current_wave)

func spawn_orc() -> void:
	var new_orc : Node2D = orc_scene.instantiate()
	new_orc.scale *= 0.15
	new_orc.path = path
	emit_signal("enemy_spawned", new_orc, position)

func _on_unit_timer_timeout():
	spawn_orc()
	wave_units[0] -= 1
	if wave_units[0] > 0:
		unit_timer.start()
	else:
		wave_units.pop_front()
		if len(wave_units) > 0:
			wave_timer.start()
		else:
			all_enemies_spawned.emit()

func _on_wave_timer_timeout():
	current_wave += 1
	unit_timer.start()
	new_wave.emit(current_wave)
