extends Area2D
class_name Projectile

var power : int
@export var speed : int = 30
@export var hit_point : int = 1
@export var time_to_live : float = 4.0

func _ready():
	pass # Replace with function body.

func init(power : int) -> Projectile:
	self.power = power
	return self

func _process(delta):
	position.x -= delta * speed
	time_to_live -= delta
	if global_position.x < 0 || time_to_live <= 0:
		queue_free()


func _on_area_entered(area):
	if area is BaseZombie:
		area.take_damage(power)
		if hit_point > 0: hit_point -= 1
		if hit_point == 0: queue_free()
