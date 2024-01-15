extends Boss

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node2D = $StateMachine

func activate() -> void:
	state_machine.change_state("Move")

func _on_health_died() -> void:
	if _dying:return
	_dying = true
	died.emit()
	await state_machine.change_state("Death")
