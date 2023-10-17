extends Attack

@onready var laser = $Laser
@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_stream_player_2 = $AudioStreamPlayer2

var current_damage: int = 0
var current_enemy: Enemy = null

func attack(enemy: Enemy, damage: int) -> void:
	laser.fire_laser(enemy)
	current_damage = damage
	current_enemy= enemy

func _on_laser_hit():
	AudioManager.request_sound(audio_stream_player)
	AudioManager.request_sound(audio_stream_player_2)
	if current_enemy == null: return
	current_enemy.take_damage(current_damage)
