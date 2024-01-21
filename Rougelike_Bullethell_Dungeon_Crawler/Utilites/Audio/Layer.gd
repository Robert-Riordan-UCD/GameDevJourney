class_name AudioLayer
extends AudioStreamPlayer

@export var fade_time:float = 1.0

enum State {UNMUTED, FADING, MUTED}

@onready var current_state:AudioLayer.State = State.MUTED

func _ready() -> void:
	volume_db = -80

func fade_in() -> void:
	if current_state == State.FADING: return
	print("Fading in ", name)
	current_state = State.FADING
	
	var tween:Tween = create_tween()
	tween.tween_property(self, "volume_db", 0, fade_time)
	await tween.finished
	
	current_state = State.UNMUTED

func fade_out() -> void:
	if current_state == State.FADING: return
	print("Fading out ", name)
	current_state = State.FADING
	
	var tween:Tween = create_tween()
	tween.tween_property(self, "volume_db", -80, fade_time)
	await tween.finished
	
	current_state = State.UNMUTED

func fade_out_and_stop() -> void:
	await fade_out()
	stop()

func start() -> void:
	play()
