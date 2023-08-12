extends Area2D

func _on_area_entered(area):
	if(area is BaseZombie):
		for zomb in $"../ZombieManager".get_children():
			if zomb is BaseZombie:
				zomb.queue_free()
		print("Game Over")
