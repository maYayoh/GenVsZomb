extends BaseTile
class_name TowerTile

enum Boolean {NULL, TRUE, FALSE}

var active : bool = true
@export var munition : PackedScene = null
@export var power : int = 0
@export var time_between_attacks : float = 1
@onready var manager = get_node("/root/World/ZombieManager")

func _ready():
	super._ready()
	$Timer.wait_time = time_between_attacks

func on_day():
	super.on_day()
	$Timer.stop()
	on_click(true)

func on_night():
	super.on_night()
	$Timer.start()
	

func _on_timer_timeout():
	if manager.get_child_count() > 1 && active:
		for zomb in manager.get_children():
			if zomb is BaseZombie && zomb.global_position.x > -1 && (
				abs(self.global_position.y - zomb.global_position.y) < 10):
					var bullet : Projectile = munition.instantiate().init(power)
					bullet.position = Vector2.ZERO
					self.add_child(bullet)

func on_click(force_true : bool = false):
	active = !active || force_true
	$Inactive.visible = !active
