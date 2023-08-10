extends BaseTile
class_name GeneratorBase

var energy_producing : int

func _init(health : int, money_cost: int, energy_producing : int):
	super(health, money_cost, -energy_producing)
	self.energy_producing = energy_producing
	
func on_day():
	# TODO: add energy producing to player energy
	super.on_day()
