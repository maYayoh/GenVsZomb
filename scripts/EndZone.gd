extends Area2D

func _on_area_entered(area):
	if(area is BaseZombie):
		for zomb in $"../ZombieManager".get_children():
			zomb.queue_free()
		print("Game Over")
