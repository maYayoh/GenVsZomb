extends Node2D
class_name EncycloMenu

var zombiesCount : Array

func _ready():
	position.y = 64
	get_node("/root/World/Camera2D").offset.y = 64
	
	for i in $zombies.get_child_count():
		var zombie = $zombies.get_child(i)
		(zombie.get_child(0) as Sprite2D).set_frame(zombiesCount[i]/10)
		(zombie.get_child(1) as Sprite2D).set_frame(zombiesCount[i]%10)

func init(zombiesCount : Array) -> EncycloMenu:
	self.zombiesCount = zombiesCount
	return self

func _on_timer_timeout():
	$Fond.modulate = Color(randf(), randf(), randf())
