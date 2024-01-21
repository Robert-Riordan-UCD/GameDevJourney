extends Item

@export var heal_amount:int = 2

func use(user:Node) -> void:
	if user is Player:
		user.health.heal(heal_amount)
	super.use(user)
