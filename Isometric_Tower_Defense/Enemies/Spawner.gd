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
var wolf_scene := preload("res://Enemies/Wolf.tscn")
var first_spawn := true

func _ready():
	randomize()
	unit_timer.wait_time = wait_between_units
	wave_timer.wait_time = wait_between_waves

func start() -> void:
	unit_timer.start()
	new_wave.emit(current_wave)

func spawn_unit() -> void:
	var new_unit : Node2D
	if randf() > 0.5:
		new_unit = orc_scene.instantiate()
	else:
		new_unit = wolf_scene.instantiate()
	new_unit.path = path.path()
	emit_signal("enemy_spawned", new_unit, position)

func _on_unit_timer_timeout():
	spawn_unit()
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
