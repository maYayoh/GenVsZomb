extends Node2D
class_name LabMenu

var zombiesCount : Array

func _ready():
	position.y = 64
	get_node("/root/World/Camera2D").offset.y = 64
	
	for loop in $zombies.get_child_count():
		var zombie = $zombies.get_child(loop)
		(zombie.get_child(0) as Sprite2D).frame = zombiesCount[loop]/10
		(zombie.get_child(1) as Sprite2D).frame = zombiesCount[loop]%10

func init(zombiesCount : Array):
	self.zombiesCount = zombiesCount
	return self

func _on_timer_timeout():
	$Fond.modulate = Color(randf(), randf(), randf())
