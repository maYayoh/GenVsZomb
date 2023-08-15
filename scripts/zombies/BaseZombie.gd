extends Area2D
class_name BaseZombie

signal attack(Zombie : BaseZombie)

@export var type : ZombieType
@export var health : int = 10
@export var power : int = 1
@export var time_between_moves : float = 1
@export var money_gained : int = 1

var primed : bool = false

enum ZombieType {SMALL_ZOMBIE, TALL_ZOMBIE, BIG_ZOMBIE}

func _ready():
	$Timer.wait_time = time_between_moves
	tree_exiting.connect(_on_tree_exiting)
	
func take_damage(damageAmount):
	health -= damageAmount
	if health <= 0:
		queue_free()

func _on_timer_timeout():
	if(primed):
		attack.emit(self)
		position.y -= 1
		await get_tree().process_frame
		position.y += 1
	else:
		position.x += 1


func _on_tree_exiting():
	(get_parent() as ZombieManager).update_ressources.emit(-money_gained, 0)


func _on_hurt_box_area_entered(area):
	if(area is BaseTile):
		primed = true
		attack.connect(area.on_damage)

func _on_hurt_box_area_exited(area):
	if(area is BaseTile):
		primed = false
		attack.disconnect(area.on_damage)
