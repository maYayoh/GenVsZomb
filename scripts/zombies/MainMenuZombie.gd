extends Sprite2D

const Type = BaseZombie.ZombieType
var speed : float

var textures : Array = [
	preload("res://assets/textures/zombies/tallzomb.png"),
	preload("res://assets/textures/zombies/bigzomb.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var type : Type = Type.SMALL_ZOMBIE
	var rand : int = randi_range(0, 20)
	if rand == 0:
		type = Type.TALL_ZOMBIE
	elif rand == 20:
		type = Type.BIG_ZOMBIE
	
	position = Vector2(-3, 10)
	match(type):
		Type.SMALL_ZOMBIE:
			$Timer.wait_time = 0.5
			offset.y = 0
		Type.TALL_ZOMBIE:
			$Timer.wait_time = 1.1
			self.set_texture(textures[0])
		Type.BIG_ZOMBIE:
			$Timer.wait_time = 1.9
			self.set_texture(textures[1])

func _on_timer_timeout():
	position.x += 1
	if global_position.x > 35:
		queue_free()
