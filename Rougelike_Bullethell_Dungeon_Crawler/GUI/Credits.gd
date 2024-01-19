extends Control

func _ready() -> void:
	$MarginContainer/BackButton.grab_focus()

func _on_back_button_pressed() -> void:
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_ui_interact"):
		$MarginContainer/BackButton.pressed.emit()
