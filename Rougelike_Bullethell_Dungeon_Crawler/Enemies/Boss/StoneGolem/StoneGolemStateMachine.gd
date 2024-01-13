extends Node

@export var initial_state:State = null

var current_state:State = null
var states:Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(change_state)
	
	if initial_state:
		await get_tree().process_frame
		await initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(state:String) -> void:
	if state == current_state.name: return
	
	var new_state:State = states.get(state)
	if not new_state: return
	
	if current_state:
		await current_state.exit()
	await new_state.enter()
	current_state = new_state
