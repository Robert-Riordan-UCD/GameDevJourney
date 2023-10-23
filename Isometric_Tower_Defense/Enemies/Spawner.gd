extends Node2D

signal enemy_spawned(enemy, position)
signal all_enemies_spawned
signal wave_finished
signal new_wave(wave_number)

@export var path : Node2D

@export_category("Waves")
@export var wait_between_waves : float = 10

@onready var wave_timer = $WaveTimer

@onready var current_wave : int = 1


func _ready():
	randomize()
	wave_timer.wait_time = wait_between_waves
	for child in get_children():
		if child is Wave:
			child.spawn_unit.connect(spawn_unit)
			child.wave_complete.connect(wave_complete)

func start() -> void:
	new_wave.emit(current_wave)
	for child in get_children():
		if child is Wave:
			child.start()
			return

func spawn_unit(unit: PackedScene) -> void:
	var new_unit : Enemy = unit.instantiate()
	new_unit.path = path.path()
	emit_signal("enemy_spawned", new_unit, position)

func wave_complete():
	await get_tree().process_frame
	for child in get_children():
		if child is Wave:
			wave_timer.start()
			wave_finished.emit()
			return
	all_enemies_spawned.emit()

func _on_wave_timer_timeout():
	current_wave += 1
	new_wave.emit(current_wave)
	for child in get_children():
		if child is Wave:
			child.start()
			return

func _on_next_wave_button_pressed():
	_on_wave_timer_timeout()
	wave_timer.stop()
