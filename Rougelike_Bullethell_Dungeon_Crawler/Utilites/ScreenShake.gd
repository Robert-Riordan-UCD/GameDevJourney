extends Node

@export var enabled:bool = true

@onready var noise:FastNoiseLite = FastNoiseLite.new()
var noise_i:float = 0.0

var _speed:float = 0
var _strength:float = 0
var _decay_rate:float = 0

var camera:Camera2D = null

func _process(delta: float) -> void:
	if not enabled or not camera: return
	
	_strength = lerp(_strength, 0.0, _decay_rate*delta)
	var shake_offset:Vector2 = get_noise_offset(delta, _speed, _strength)
	camera.position = shake_offset

func screen_shake(speed:float, strength:float, decay_rate:float) -> void:
	camera = Utils.get_current_camera()
	_speed = speed
	_strength = strength
	_decay_rate = decay_rate

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)
