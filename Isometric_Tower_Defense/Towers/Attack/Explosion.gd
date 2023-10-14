class_name Explosion
extends CPUParticles2D

@export var duration : float = 0.75

func _ready() -> void:
	$Timer.wait_time = duration
	$Timer.start()
	emitting = true

func _on_timer_timeout():
	queue_free()
