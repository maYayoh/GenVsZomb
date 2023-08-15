extends Area2D
class_name BaseTile

@export var type : TileManager.TileType
@export var health : int = 0
@export var money_cost : int = 0
@export var energy_cost : int = 0

var newly_placed : bool = true
var audio : AudioStreamPlayer

func _ready():
	audio = get_parent().get_child(2)
	# Transparent by default
	modulate.a = 0.7
	tree_exiting.connect(on_destroy)

func on_day():
	pass

func on_night():
	newly_placed = false
	modulate.a = 1

func on_damage(zombie : BaseZombie):
	health -= zombie.power
	if(health <= 0):
		audio.play()
		queue_free()

func on_destroy():
	$"../..".update_ressources.emit(-money_cost if newly_placed else 0, -energy_cost)
