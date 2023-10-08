class_name GUI
extends Control

@onready var gold_amount = $VBoxContainer/HBoxContainer/GoldAmount
@onready var wave_counter = $VBoxContainer/HBoxContainer/WaveCounter
@onready var health = $VBoxContainer/HBoxContainer/Health

var total_waves : int

func set_gold_amount(amount: int) -> void:
	gold_amount.text = str(amount)

func set_health(h: int) -> void:
	health.text = str(h)

func set_total_waves(waves: int) -> void:
	total_waves = waves

func set_current_wave(wave: int) -> void:
	wave_counter.text = "Wave " + str(wave) + " / " + str(total_waves)
