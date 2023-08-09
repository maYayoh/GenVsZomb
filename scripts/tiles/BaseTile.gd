extends Area2D
class_name BaseTile

var health : int
var max_health : int
var money_cost : int
var energy_cost : int
var newly_placed : bool = true

func _init(hp : int, cost : int, energy : int):
	self.health = hp
	self.max_health = hp
	self.money_cost = cost
	self.energy_cost = energy
	# Transparent by default
	modulate.a = 0.5
	
	input_event.connect(on_click)

func on_day():
	pass

func on_night():
	newly_placed = false
	modulate.a = 1

func on_click(_viewport, event, _shape_idx):
	push_error(self.name + "'s Click event missing")

func on_damage(power : int):
	print(name + " " + str(health))
	health -= power
	if(health <= 0):
		queue_free()
