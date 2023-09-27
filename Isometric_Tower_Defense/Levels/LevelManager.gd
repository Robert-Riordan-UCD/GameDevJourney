class_name LevelManager
extends Node2D

@export var gold : int = 500

@onready var gui : GUI = $GUI

func _ready():
	gui.set_gold_amount(gold)

func spend_gold(amount: int) -> bool:
	if amount > gold or amount <= 0:
		return false
	gold -= amount
	gui.set_gold_amount(gold)
	return true
