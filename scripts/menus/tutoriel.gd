extends Node2D

@onready var text : Sprite2D = $Sprite2D
@onready var sprites : Array = [
	$Sprite2D1, $Sprite2D2, $Sprite2D3,
	$Sprite2D4, $Sprite2D5, $Sprite2D6,
]

func _ready():
	position.y = 64
	get_node("/root/MainMenu/Camera2D").offset.y = 64
	
	text.frame = 0
	update_sprite()

func _on_back_pressed():
	if(text.frame == 0):
		get_node("/root/MainMenu/Camera2D").offset.y = 0
		queue_free()
	else:
		text.frame -= 1
		update_sprite()


func _on_next_pressed():
	if(text.frame == 5):
		get_node("/root/MainMenu/Camera2D").offset.y = 0
		queue_free()
	else:
		text.frame += 1
		update_sprite()


func update_sprite():
	for sprite in sprites:
		sprite.visible = false
	sprites[text.frame].visible = true
