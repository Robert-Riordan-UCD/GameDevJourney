extends Boss

func activate() -> void:
	super.activate()
	state_machine.change_state("Move")
