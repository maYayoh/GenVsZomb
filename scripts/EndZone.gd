extends Area2D

var game_over : TextureButton = preload("res://scenes/menus/game_over_screen.tscn").instantiate()

func _on_area_entered(area):
	if(area is BaseZombie):
#		for zomb in $"../ZombieManager".get_children():
#			if zomb is BaseZombie:
#				zomb.queue_free()
		$"../Music".die()
		get_owner().add_child(game_over)
