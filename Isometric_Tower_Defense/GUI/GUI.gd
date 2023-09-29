class_name GUI
extends Control

@onready var gold_amount = $VBoxContainer/HBoxContainer/GoldAmount
@onready var health = $VBoxContainer/HBoxContainer/Health

func set_gold_amount(amount: int) -> void:
	gold_amount.text = str(amount)

func set_health(h: int) -> void:
	health.text = str(h)
