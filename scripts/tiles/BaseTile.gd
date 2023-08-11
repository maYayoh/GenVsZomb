extends Area2D
class_name BaseTile

@export var health : int = 0
@export var money_cost : int = 0
@export var energy_cost : int = 0
@export var menu : PackedScene = null
var newly_placed : bool = true

func _ready():
	# Transparent by default
	modulate.a = 0.5
	
	input_event.connect(on_click)
	tree_exiting.connect(on_destroy)

func on_day():
	pass

func on_night():
	newly_placed = false
	modulate.a = 1

func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if (menu != null):
			pass
		else:
			push_error(self.name + "'s Menu Scene is missing")

func on_damage(power : int):
	health -= power
	if(health <= 0):
		queue_free()

func on_destroy():
	($"../.." as TileManager).update_ressource.emit(-money_cost if newly_placed else 0, -energy_cost)
