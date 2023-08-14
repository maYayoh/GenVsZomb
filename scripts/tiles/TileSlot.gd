extends Area2D
class_name TileSlot

var tile : BaseTile = null
var locked : bool = false

func on_day():
	locked = false
	if tile != null:
		tile.on_day()

func on_night():
	locked = true
	if tile != null:
		tile.on_night()


func add_building(node : BaseTile):
	tile = node
	add_child(tile)

func change_building(node : BaseTile):
	tile.queue_free()
	add_building(node)


func energy_check(Warning : PackedScene, safe : bool):
	if tile == null: return
	if tile.get_child_count() == 4:
		tile.get_child(3).queue_free()
	
	if tile is BaseTile && tile.energy_cost > 0:
		if not safe:
			var warning : Sprite2D = Warning.instantiate()
			tile.add_child(warning)


func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && not locked):
		$Click.play()
		get_owner().cursor_pos = self.position
		if (tile == null):
			get_parent().select_slot(self)
		else:
			get_parent().look_menu(self, tile.type)
