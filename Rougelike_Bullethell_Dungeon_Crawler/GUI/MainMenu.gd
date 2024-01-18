extends Control

func _on_play_button_pressed():
	SceneTransition.change_scene("res://World/Levels/level.tscn")

func _on_credit_button_pressed() -> void:
	$VBoxContainer/CreditButton.text = "I haven't added this yet"
	#SceneTransition.change_scene("res://GUI/LevelSelectScreen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
