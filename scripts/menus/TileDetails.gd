extends TextureButton
class_name TileDetails

func _ready():
	get_node("/root/World/Camera2D").offset.y = 64

func init(health : int, stat : int = -1) -> TileDetails:
	$Heart/DizainH.set_frame(health / 10)
	$Heart/UnitH.set_frame(health % 10)
	
	if stat != -1:
		$Stat/UnitS.set_frame(stat if stat<10 else 12)
	
	return self

func _on_pressed():
	get_node("/root/World/Camera2D").offset.y = 0
	self.queue_free()
