extends Control

@onready var buttons: VBoxContainer = $Buttons
@onready var active_button:int = 0
@onready var button_timer:Timer = $ButtonTimer

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
	SceneTransition.change_scene("res://World/Levels/level.tscn")

func _on_credit_button_pressed() -> void:
	SceneTransition.change_scene("res://GUI/Credits.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
