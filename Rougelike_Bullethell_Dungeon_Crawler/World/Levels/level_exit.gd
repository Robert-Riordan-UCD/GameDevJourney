extends Node2D

func unlock() -> void:
	$Grate.visible = false
	$ExitTrigger.monitoring = true

func _on_exit_trigger_body_entered(body: Node2D) -> void:
	print("Level complete!")
