extends Control

@onready var buttons: VBoxContainer = $Buttons
@onready var active_button:int = 0
@onready var button_timer:Timer = $ButtonTimer
@onready var click_sound_effect: AudioStreamPlayer = $ClickSoundEffect

func _ready() -> void:
	buttons.get_children()[active_button].call_deferred("grab_focus")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_ui_interact"):
		buttons.get_children()[active_button].pressed.emit()
	
	if button_timer.is_stopped() and event.is_action_pressed("player_up"):
		active_button = (active_button-1)%buttons.get_child_count()
		buttons.get_children()[active_button].call_deferred("grab_focus")
		button_timer.start()
	
	if button_timer.is_stopped() and event.is_action_pressed("player_down"):
		active_button = (active_button+1)%buttons.get_child_count()
		buttons.get_children()[active_button].call_deferred("grab_focus")
		button_timer.start()

func _on_play_button_pressed():
	MusicBus.set_intensity(1)
	click_sound_effect.play()
	SceneTransition.change_scene("res://World/Levels/level.tscn")

func _on_settings_button_pressed() -> void:
	click_sound_effect.play()
	SceneTransition.change_scene("res://GUI/settings.tscn")

func _on_credit_button_pressed() -> void:
	click_sound_effect.play()
	SceneTransition.change_scene("res://GUI/Credits.tscn")

func _on_quit_button_pressed() -> void:
	click_sound_effect.play()
	get_tree().quit()
