extends Area2D
class_name Projectile

var power : int
@export var hit_point : int = 1
@export var speed : int = 30


func _ready():
	pass # Replace with function body.

func init(power : int) -> Projectile:
	self.power = power
	print(self.power)
	return self

func _process(delta):
	position.x -= delta * speed


func _on_area_entered(area):
	if area is BaseZombie:
		area.take_damage(power)
		hit_point -= 1
		if hit_point <= 0:
			queue_free()
