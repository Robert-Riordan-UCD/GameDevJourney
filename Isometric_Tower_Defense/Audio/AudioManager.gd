extends Node2D

@export var timeout_min : float = 0.0
@export var timeout_max : float = 1.0

@onready var timed_out := {}
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	randomize()

func request_sound(audio_player: AudioStreamPlayer) -> bool:
	if audio_player in timed_out:
		return false
	get_tree().create_timer(randf_range(timeout_min, timeout_max)).connect("timeout", _timeout.bind(audio_player))
	timed_out[audio_player] = ''
	audio_player.play()
	return true

func _timeout(audio_player: AudioStreamPlayer) -> void:
	if audio_player in timed_out:
		timed_out.erase(audio_player)

func _on_audio_stream_player_finished():
	audio_stream_player.play()
