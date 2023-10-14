extends Attack

@onready var laser = $Laser

var current_damage: int = 0
var current_enemy: Enemy = null

func attack(enemy: Enemy, damage: int) -> void:
	laser.fire_laser(enemy)
	current_damage = damage
	current_enemy= enemy

func _on_laser_hit():
	if current_enemy == null: return
	current_enemy.take_damage(current_damage)
