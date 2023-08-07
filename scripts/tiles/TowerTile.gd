extends "res://scripts/tiles/BaseTile.gd"


@export var energy_producing : int

func _init():
	super(30, 30, 0)
	
func on_night():
	# add energy producing to player energy
	pass
