extends Node2D
class_name ZombieManager

signal update_ressources(money, energy)

const LittleZombie = preload("res://scenes/zombies/LittleZombie.tscn")
const BigZombie = preload("res://scenes/zombies/BigZombie.tscn")
const TallZombie = preload("res://scenes/zombies/TallZombie.tscn")

func _ready():
	for loop in range(10):
		spawnZombie(LittleZombie, randi_range(0,4))

func spawnZombie(typeZombie : PackedScene, lane : int):
	var zombie = typeZombie.instantiate()
	add_child(zombie)
	zombie.position.y = lane * 13 + 6 + randi_range(-2,2)
	zombie.position.x = -randi_range(2, 20)
