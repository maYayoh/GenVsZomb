extends BaseTile

@export var money_gained : float = 1.0

func on_day():
	money_gained += 0.75
	$"../..".update_ressources.emit(floor(money_gained), 0)
