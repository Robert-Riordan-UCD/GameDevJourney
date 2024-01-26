extends Control

@onready var volume_slider: HSlider = $Buttons/Volume/HSlider

@onready var buttons:Array[Control] = [$Buttons/Volume/HSlider, $Buttons/BackButton]
@onready var active_button:int = 0
@onready var button_timer:Timer = $ButtonTimer
@onready var click_sound_effect: AudioStreamPlayer = $ClickSoundEffect

func _ready() -> void:
	volume_slider.value = MusicBus.max_volume
	MusicBus.set_intensity(1)
	click_sound_effect.play()
	buttons[active_button].call_deferred("grab_focus")

func _on_h_slider_value_changed(value: float) -> void:
	click_sound_effect.play()
	MusicBus.update_max_volume(value)

func _on_back_button_pressed() -> void:
	MusicBus.set_intensity(0)
	click_sound_effect.play()
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_ui_interact"):
		if buttons[active_button].has_signal("pressed"):
			buttons[active_button].pressed.emit()
	
	if button_timer.is_stopped() and event.is_action_pressed("player_up"):
		active_button = (active_button-1)%buttons.size()
		buttons[active_button].call_deferred("grab_focus")
		button_timer.start()
	
	if button_timer.is_stopped() and event.is_action_pressed("player_down"):
		active_button = (active_button+1)%buttons.size()
		buttons[active_button].call_deferred("grab_focus")
		button_timer.start()
	
	if event.is_action_pressed("player_left") and "value" in buttons[active_button]:
		buttons[active_button].value -= 1
		
	if event.is_action_pressed("player_right") and "value" in buttons[active_button]:
		buttons[active_button].value += 1
