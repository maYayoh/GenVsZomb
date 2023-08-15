extends Node2D

@onready var text : Sprite2D = $Sprite2D
@onready var sprites : Sprite2D = $Sprite2D2

func _ready():
	position.y = 64
	get_node("/root/main_menu/Camera2D").offset.y = 64
	
	text.frame = 0
	sprites.frame = 0

func _on_back_pressed():
	if(text.frame == 0):
		get_node("/root/main_menu/Camera2D").offset.y = 0
		queue_free()
	else:
		text.frame -= 1
		sprites.frame -= 1


func _on_next_pressed():
	if(text.frame == 5):
		get_node("/root/main_menu/Camera2D").offset.y = 0
		queue_free()
	else:
		text.frame += 1
		sprites.frame += 1
