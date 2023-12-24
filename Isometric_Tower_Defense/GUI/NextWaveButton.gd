extends MarginContainer

signal next_wave_button_pressed(time_left)

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
	next_wave_button_pressed.emit(int(timer.time_left))
	hide_next_wave_button()

func hide_next_wave_button():
	await Utils.tween_out(self)

func show_next_wave_button():
	Utils.tween_in(self)
