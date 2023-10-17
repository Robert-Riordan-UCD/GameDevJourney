extends Attack

@onready var arrow := preload("res://Towers/Attack/CrossbowArrow.tscn")
@onready var audio_stream_player = $AudioStreamPlayer

func attack(enemy: Enemy, damage: int) -> void:
	var new_arrow : CrossBowArrow = arrow.instantiate()
	new_arrow.hit.connect(arrow_hit.bind(enemy, damage))
	add_child(new_arrow)
	new_arrow.goto(enemy.global_position)
	AudioManager.request_sound(audio_stream_player)

func arrow_hit(enemy: Enemy, damage: int) -> void:
	if enemy == null: return
	enemy.take_damage(damage)
