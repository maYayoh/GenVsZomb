extends ColorRect
class_name EncycloMenu

var zombiesCount : Array
var can_cure : bool = false

func _ready():
	position.y = 64
	get_node("/root/World/Camera2D").offset.y = 64
	
	var total : int = 0
	total += int(zombiesCount[0])
	total += int(zombiesCount[1] *3)
	total += int(zombiesCount[2] *5)
	
	for i in $zombies.get_child_count():
		var zombie = $zombies.get_child(i)
		(zombie.get_child(0).get_child(0) as Sprite2D).set_frame(zombiesCount[i]/10)
		(zombie.get_child(0).get_child(1) as Sprite2D).set_frame(zombiesCount[i]%10)
	
	var progress : float = total/30.0
	if progress >= 1.0:
		$Cure/AnimationPlayer.play("blink")
		can_cure = true
	else:
		$Analyse/Cover.set_size(Vector2(30,(43-43*progress)))


func init(zombiesCount : Array) -> EncycloMenu:
	self.zombiesCount = zombiesCount
	return self


func _on_texture_button_pressed():
	get_node("/root/World/Validation").play()
	get_node("/root/World/Camera2D").offset.y = 0
	self.queue_free()



func _on_cure_pressed():
	if can_cure:
		get_node("/root/World/Music").die()
		get_tree().change_scene_to_file("res://scenes/menus/cured_screen.tscn")
	else:
		get_node("/root/World/Cancel").play()
