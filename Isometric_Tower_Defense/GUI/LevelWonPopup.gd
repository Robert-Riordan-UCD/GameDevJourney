extends PopupPanel

@export var next_level_path: String

func display() -> void:
	if visible: return
	var popup_size = get_size()
	var screen_center = DisplayServer.window_get_size()/2
	popup(Rect2i(screen_center.x-popup_size.x/2, screen_center.y-popup_size.y/2, popup_size.x, popup_size.y))

func _on_next_level_button_pressed():
	SceneTransition.change_scene(next_level_path)

func _on_menu_button_pressed():
	$VBoxContainer/MenuButton.text = "Woops!\nThere's no menu yet."
