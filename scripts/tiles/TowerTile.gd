extends BaseTile

@export var Projectile : PackedScene = null
@export var power : int = 0
@export var time_between_attacks : float = 1

func _ready():
	super._ready()
	%Timer.wait_time = time_between_attacks

func _on_timer_timeout():
	# spawn projectile
	print("piou")
