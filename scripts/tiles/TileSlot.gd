extends Area2D
class_name TileSlot

var tile : Area2D = null

func add_building(node : Area2D):
	tile = node
	add_child(tile)

func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		get_owner().cursor_pos = self.position
		if (tile == null):
			get_parent().select_slot(self)
