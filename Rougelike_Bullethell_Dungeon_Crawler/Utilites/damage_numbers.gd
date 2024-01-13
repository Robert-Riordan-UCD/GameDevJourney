extends Node

const appear_time:float = 0.25
const disappear_time:float = 0.25
const move_distance:float = 30

func display_number(value:int, position:Vector2, crit:bool=false) -> void:
	var number:Label = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 100
	
	number.label_settings = LabelSettings.new()
	number.label_settings.font_color = "#B22" if crit else "#FFF"
	number.label_settings.font_size = 24
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = number.size/2
	
	var tween:Tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, 'position:y', position.y-move_distance, appear_time).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, 'position:y', position.y+move_distance, disappear_time).set_ease(Tween.EASE_IN).set_delay(appear_time)
	tween.tween_property(number, 'scale', Vector2.ZERO, disappear_time).set_ease(Tween.EASE_IN).set_delay(appear_time)
	
	await tween.finished
	number.queue_free()
