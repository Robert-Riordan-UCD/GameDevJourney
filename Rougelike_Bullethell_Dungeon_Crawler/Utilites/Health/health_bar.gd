extends ProgressBar

@export var health:Health = null

func _ready() -> void:
	max_value = health.max_health
	value = health.current_health
	
	health.damaged.connect(_update_health)
	health.died.connect(_update_health)
	health.healed.connect(_update_health)

func _update_health() -> void:
	var tween:Tween = create_tween()
	max_value = health.max_health
	tween.tween_property(self, "value", health.current_health, 0.4)
