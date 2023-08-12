extends TextureButton
class_name TileDetails

func _ready():
	get_node("/root/World/Camera2D").offset.y = 64

func init(health : int) -> TileDetails:
	$Heart/DizainH.set_frame(health / 10)
	$Heart/UnitH.set_frame(health % 10)
	
	return self

func _on_pressed():
	get_node("/root/World/Camera2D").offset.y = 0
	self.queue_free()
