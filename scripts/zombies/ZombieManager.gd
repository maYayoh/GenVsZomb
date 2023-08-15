extends Node2D
class_name ZombieManager

signal update_ressources(money, energy)

const LittleZombie = preload("res://scenes/zombies/smol_zombie.tscn")
const BigZombie = preload("res://scenes/zombies/big_zombie.tscn")
const TallZombie = preload("res://scenes/zombies/tall_zombie.tscn")
@export var spawn_distance : int = 6

class MinMaxValue :
	var minVal : int
	var maxVal : int
	
	func _init(minVal : int = 1, maxVal : int = 5):
		self.minVal = minVal
		self.maxVal = maxVal


func _ready():
	pass


func spawn_zombie(typeZombie : PackedScene, lane : int, distance_multiplier : float):
	var zombie = typeZombie.instantiate()
	zombie.position.y = (lane-1) * 13 + 6 + randi_range(-3,3)
	zombie.position.x = -ceil(
		randf_range(spawn_distance,
		spawn_distance*distance_multiplier))
	add_child(zombie)

func spawn_wave(x : int, lanes : MinMaxValue = MinMaxValue.new()):
	var f_x : float = x*0.8+exp(0.01*x)+4
	var g_x : float = cos(x*exp(0.01*x))-sin(x*exp(0.01*x)) * 2.1*x*exp(0.01)
	var h_x : float = sin(x*exp(0.01*x))-cos(x*exp(0.01*x)) * 2.1*x*exp(0.01)
	
#	print("***********")
#	print(f_x)
#	print(g_x)
#	print(h_x)
	
	var number_of_zombs : int = roundi(f_x)
	
	var number_of_bigs : int = roundi((0.3*x*g_x)/f_x)
	var number_of_talls : int = roundi((0.3*x*h_x)/f_x)
	
	var number_of_smols : int = number_of_zombs - (
		(number_of_bigs if number_of_bigs > 0 else 0) +
		(number_of_talls if number_of_talls > 0 else 0)
	)
	
#	print("==========")
#	print("SMOL\t"+str(number_of_smols))
#	print("TALL\t"+str(number_of_talls))
#	print("BIG\t\t"+str(number_of_bigs))
#	print("TOTAL\t"+str(number_of_zombs))
	
	for i in range(number_of_smols):
		spawn_zombie(LittleZombie, randi_range(lanes.minVal, lanes.maxVal), 5)
	
	for i in range(number_of_bigs):
		spawn_zombie(BigZombie, randi_range(lanes.minVal, lanes.maxVal), 3)
	
	for i in range(number_of_talls):
		spawn_zombie(TallZombie, randi_range(lanes.minVal, lanes.maxVal), 1.2)


func on_night(difficulty : int):
	$CheckEndWave.start()
	match(difficulty):
		0, 1:
			spawn_wave(difficulty, MinMaxValue.new(3, 3))
		2:
			spawn_wave(2, MinMaxValue.new(2, 4))
		_:
			spawn_wave(difficulty)

func _on_check_end_wave_timeout():
	if self.get_child_count() <= 1:
		$"..".on_day()
	else:
		$CheckEndWave.start()
