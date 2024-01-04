class_name Weapon
extends Sprite2D

@export var flipped:bool = false

@onready var attacking:bool = false
@onready var hit_box: HitBox = $HitBox

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_main_hand"):
		attack()

func attack() -> void:
	if attacking: return
	attacking = true
	var tween:Tween = create_tween()
	if flipped:
		tween.tween_property(self, "rotation_degrees", -180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(self, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		tween.tween_property(self, "rotation_degrees", 180, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(self, "rotation_degrees", 0, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	attacking = false
