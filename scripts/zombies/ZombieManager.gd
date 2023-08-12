extends Node2D
class_name ZombieManager

signal update_ressources(money, energy)

const LittleZombie = preload("res://scenes/zombies/smol_zombie.tscn")
const BigZombie = preload("res://scenes/zombies/big_zombie.tscn")
const TallZombie = preload("res://scenes/zombies/tall_zombie.tscn")

func _ready():
	pass

func spawnZombie(typeZombie : PackedScene, lane : int):
	var zombie = typeZombie.instantiate()
	zombie.position.y = lane * 13 + 6 + randi_range(-3,3)
	zombie.position.x = -randi_range(6, 30)
	add_child(zombie)

func on_night():
	$CheckEndWave.start()
	for loop in range(10):
		spawnZombie(LittleZombie, randi_range(0,4))

func _on_check_end_wave_timeout():
	if self.get_child_count() <= 1:
		$"..".on_day()
	else:
		$CheckEndWave.start()
