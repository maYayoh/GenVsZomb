extends ColorRect
class_name EncycloMenu

var zombiesCount : Array

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
	$Analyse/Cover.set_size(Vector2(30,(43-43*progress)))

func init(zombiesCount : Array) -> EncycloMenu:
	self.zombiesCount = zombiesCount
	return self


func _on_texture_button_pressed():
	get_node("/root/World/Camera2D").offset.y = 0
	self.queue_free()
