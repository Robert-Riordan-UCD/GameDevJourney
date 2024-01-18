extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func change_scene(scene_name: String) -> void:
	animation_player.play("disolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_name)
	animation_player.play_backwards("disolve")
