extends Attack

@onready var arrow := preload("res://Towers/Attack/CrossbowArrow.tscn")

func attack(enemy: Enemy, damage: int) -> void:
	var new_arrow : CrossBowArrow = arrow.instantiate()
	new_arrow.hit.connect(arrow_hit.bind(enemy, damage))
	add_child(new_arrow)
	new_arrow.goto(enemy.global_position)

func arrow_hit(enemy: Enemy, damage: int) -> void:
	enemy.take_damage(damage)
