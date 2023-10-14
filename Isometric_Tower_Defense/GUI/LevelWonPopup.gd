extends PopupPanel

@export var next_level_path: String

func display() -> void:
	if visible: return
	popup_centered()

func _on_next_level_button_pressed():
	SceneTransition.change_scene(next_level_path)

func _on_menu_button_pressed():
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")

func _on_popup_hide():
	popup_centered()
