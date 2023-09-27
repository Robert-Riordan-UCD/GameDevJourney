class_name LevelManager
extends Node2D

@export var gold : int = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spend_gold(amount: int) -> bool:
	if amount > gold or amount <= 0:
		return false
	gold -= amount
	print("Gold remaing: ", gold)
	return true
