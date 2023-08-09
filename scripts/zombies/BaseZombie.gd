extends Area2D
class_name BaseZombie

signal attack(power : int)

@export var health : int = 10
@export var power : int = 1
@export var timeUntilNextMove : float = 1

var primed : bool = false

#func _init(health : int = 10, power : int = 1, timeUntilNextMove : float = 1):
#	self.health = health
#	self.power = power
#	self.timeUntilNextMove = timeUntilNextMove
	
func _ready():
	$Timer.wait_time = timeUntilNextMove
	
func takeDamage(damageAmount : int = 1):
	health -= damageAmount

func _on_timer_timeout():
	if(primed):
		attack.emit(power)
	else:
		position.x += 1


func _on_area_entered(area):
	if(area is BaseTile):
		primed = true
		attack.connect(area.on_damage)


func _on_area_exited(area):
	if(area is BaseTile):
		primed = false
		attack.disconnect(area.on_damage)
