extends Attack

@export var splash_range : float = 150

@onready var bomb = preload("res://Towers/Attack/Bomb.tscn")
@onready var audio_stream_player = $AudioStreamPlayer

func attack(enemy: Enemy, damage: int) -> void:
	var new_bomb : Bomb = bomb.instantiate()
	new_bomb.splash_range = splash_range
	add_child(new_bomb)
	new_bomb.goto(enemy.global_position)
	new_bomb.hit.connect(_bomb_landed.bind(enemy, damage))

func _bomb_landed(hits: Array, enemy: Enemy, damage: int) -> void:
	AudioManager.request_sound(audio_stream_player)
	for area in hits:
		if area is Enemy:
			area.take_damage(damage)
