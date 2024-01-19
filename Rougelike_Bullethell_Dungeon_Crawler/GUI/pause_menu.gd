extends Control

@onready var _paused:bool = false
@onready var buttons:VBoxContainer = $Buttons
@onready var active_button:int = 0
@onready var button_timer:Timer = $ButtonTimer

func _ready() -> void:
	unpause()

func pause() -> void:
	_paused = true
	visible = true
	get_tree().paused = true
	buttons.get_children()[active_button].call_deferred("grab_focus")

func unpause() -> void:
	get_tree().paused = false
	visible = false
	_paused = false
	active_button = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_pause"):
		pause()
	
	if not _paused: return
	
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

func _on_play_button_pressed() -> void:
	unpause()

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
