extends MarginContainer

@export var parent: Node2D
@export var timer: Timer

@onready var next_wave_button = $NextWaveButton

func _ready():
	if parent:
		global_position = parent.global_position - size

func _process(_delta):
	if timer.is_stopped():
		next_wave_button.text = "Next wave"
	else:
		next_wave_button.text = str(timer.time_left).split('.')[0]

func _on_next_wave_button_pressed():
	hide_next_wave_button()

func hide_next_wave_button():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 1.0).set_trans(Tween.TRANS_CIRC)

func show_next_wave_button():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 1.0).set_trans(Tween.TRANS_CIRC)
