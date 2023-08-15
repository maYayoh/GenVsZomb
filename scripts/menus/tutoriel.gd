extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	position.y = 64
	get_node("/root/main_menu/Camera2D").offset.y = 64

func _on_back_pressed():
	if(sprite.frame == 0):
		get_node("/root/main_menu/Camera2D").offset.y = 0
		queue_free()
	else:
		sprite.frame -= 1


func _on_next_pressed():
	if(sprite.frame == 5):
		get_node("/root/main_menu/Camera2D").offset.y = 0
		queue_free()
	else:
		sprite.frame += 1
