extends Area2D

func _on_area_entered(area):
	if(area is BaseZombie):
		print("Game Over")
