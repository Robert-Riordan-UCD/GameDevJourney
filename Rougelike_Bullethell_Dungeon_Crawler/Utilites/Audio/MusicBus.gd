extends Node2D

@export_range(0, 3) var intensity:int = 0: set = set_intensity

@onready var layers:Array[AudioLayer] = [$Layer1, $Layer2, $Layer3]

func _ready() -> void:
	for layer in layers:
		layer.start()

func stop():
	for layer in layers:
		layer.fade_out_and_stop()

func set_intensity(new_intensity:int) -> void:
	intensity = new_intensity
	if intensity == 0:
		stop()
		return
	
	for i in range(new_intensity):
		layers[i].fade_in()
		print("Fade in layer ", i)

	for i in range(new_intensity, 3):
		layers[i].fade_out()
		print("Fade out layer ", i)

