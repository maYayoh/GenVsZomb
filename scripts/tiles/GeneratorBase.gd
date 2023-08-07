extends "res://scripts/tiles/BaseTile.gd"

var energy_producing : int

func _init(health : int, money_cost: int, energy_producing : int):
	super(health, money_cost, 0)
	self.energy_producing = energy_producing
	
func on_day():
	# TODO: add energy producing to player energy
	super.on_day()

func on_destroy():
	# TODO: remove energy producing
	super.on_destroy()
