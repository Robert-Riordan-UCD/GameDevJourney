class_name GUI
extends Control

@onready var gold_amount = $VBoxContainer/HBoxContainer/GoldAmount

func set_gold_amount(amount: int) -> void:
	gold_amount.text = str(amount)
