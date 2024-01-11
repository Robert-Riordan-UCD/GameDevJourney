extends Node2D

signal level_exited

func unlock() -> void:
	$ExitTrigger.monitoring = true
	$SpriteMask/Grate/AnimationPlayer.play("open")

func _on_exit_trigger_body_entered(body: Node2D) -> void:
	level_exited.emit()
