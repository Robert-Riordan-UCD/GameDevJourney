extends Control

func _on_play_button_pressed():
	SceneTransition.change_scene("res://Levels/Level1.tscn")

func _on_level_button_pressed():
	SceneTransition.change_scene("res://GUI/LevelSelectScreen.tscn")
