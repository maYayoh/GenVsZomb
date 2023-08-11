extends Area2D
class_name BaseZombie

signal attack(power : int)

@export var health : int = 10
@export var power : int = 1
@export var timeUntilNextMove : float = 1
@export var money_gained : int = 1

var primed : bool = false
	
func _ready():
	$Timer.wait_time = timeUntilNextMove
	tree_exiting.connect(_on_tree_exiting)
	
func takeDamage(damageAmount : int = 1):
	health -= damageAmount

func _on_timer_timeout():
	if(primed):
		attack.emit(power)
		position.y -= 1
		await get_tree().process_frame
		position.y += 1
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


func _on_tree_exiting():
	(get_parent() as ZombieManager).update_ressources.emit(-money_gained, 0)
