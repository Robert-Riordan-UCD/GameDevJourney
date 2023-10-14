extends PopupPanel

func display() -> void:
	if visible: return
	popup_centered()

func _on_retry_button_pressed():
	SceneTransition.change_scene(get_tree().current_scene.scene_file_path)

func _on_menu_button_pressed():
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")

func _on_popup_hide():
	popup_centered()
