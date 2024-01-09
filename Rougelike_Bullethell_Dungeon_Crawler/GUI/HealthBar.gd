extends Control

@onready var texture_progress_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _on_player_health_changed(health, max_health) -> void:
	texture_progress_bar.max_value = max_health
	var tween:Tween = create_tween()
	tween.tween_property(texture_progress_bar, "value", health, 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
