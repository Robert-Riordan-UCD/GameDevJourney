extends Control

func _on_level_1_pressed():
	SceneTransition.change_scene("res://Levels/Level1.tscn")

func _on_level_2_pressed():
	SceneTransition.change_scene("res://Levels/Level2.tscn")

func _on_level_3_pressed():
	SceneTransition.change_scene("res://Levels/Level3.tscn")

func _on_back_pressed():
	SceneTransition.change_scene("res://GUI/MainMenu.tscn")
