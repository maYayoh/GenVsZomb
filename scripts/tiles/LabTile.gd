extends BaseTile
class_name LabTile

@export var max_zombie_contained : int = 1

var zombies_contained : Array = []

func on_damage(zombie : BaseZombie):
	if(zombies_contained.size() < max_zombie_contained):
		contain_zombie(zombie)
	else:
		super(zombie)

func contain_zombie(zombie : BaseZombie = null):
	zombies_contained.append(zombie.type)
	zombie.queue_free()
	print(zombies_contained)

func on_day():
	if(zombies_contained.is_empty()):	
		return
	var world = get_node("/root/World") as World
	
	world.zombie_analyzed_count[0] += zombies_contained.filter(func(x) : return x == BaseZombie.ZombieType.SMALL_ZOMBIE).size()
	world.zombie_analyzed_count[1] += zombies_contained.filter(func(x) : return x == BaseZombie.ZombieType.TALL_ZOMBIE).size()
	world.zombie_analyzed_count[2] += zombies_contained.filter(func(x) : return x == BaseZombie.ZombieType.BIG_ZOMBIE).size()
	
	print((get_node("/root/World") as World).zombie_analyzed_count)
