extends Boss

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node2D = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func activate() -> void:
	state_machine.change_state("Move")
	MusicBus.set_intensity(3)

func _on_health_damaged() -> void:
	animation_player.play("hit")

func _on_health_died() -> void:
	if _dying:return
	_on_health_damaged()
	_dying = true
	died.emit()
	await state_machine.change_state("Death")
	MusicBus.set_intensity(1)
