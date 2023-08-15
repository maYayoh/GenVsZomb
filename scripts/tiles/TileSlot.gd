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
	get_parent().update_ressources.emit(tile.money_cost, tile.energy_cost)

func change_building(node : BaseTile):
	tile.newly_placed = false
	tile.queue_free()
	add_building(node)


func energy_check(safe : bool):
	if tile == null : return
		
	if tile.energy_cost > 0:
		var node = tile.get_node("Warning")
		if node != null:
			node.visible = !safe


func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if not locked:
			$Click.play()
			get_owner().cursor_pos = self.position
			if (tile == null):
				get_parent().select_slot(self)
			else:
				get_parent().look_menu(self, tile.type)
		elif tile != null && tile is TowerTile:
			tile.on_click()
