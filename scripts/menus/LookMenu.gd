extends Menu
class_name LookMenu

@onready var world = get_node("/root/World")
@export var details_scene : PackedScene = null
@export var upgrade_menu : PackedScene = null
var disabled_upgrade : bool = false
var slot : TileSlot
var tile : BaseTile

const Type = TileManager.TileType


func init(slot : TileSlot) -> LookMenu:
	self.slot = slot
	self.tile = slot.get_child(5)
	if (details_scene == null):
		match(self.tile.type):
			Type.NULL:
				push_error(self.slot.name + " don't have a TileType.")
			
			Type.GEN_A:
				details_scene = load("res://scenes/tiles/details/generatorA_details.tscn")
			Type.GEN_B:
				details_scene = load("res://scenes/tiles/details/generatorB_details.tscn")
			Type.GEN_C:
				details_scene = load("res://scenes/tiles/details/generatorC_details.tscn")
			
			Type.TOUR_A:
				details_scene = load("res://scenes/tiles/details/towerA_details.tscn")
			Type.TOUR_B:
				details_scene = load("res://scenes/tiles/details/towerB_details.tscn")
			Type.TOUR_C:
				details_scene = load("res://scenes/tiles/details/towerC_details.tscn")
			
			Type.LAB_A:
				details_scene = load("res://scenes/tiles/details/laboratoryA_details.tscn")
			Type.LAB_B:
				details_scene = load("res://scenes/tiles/details/laboratoryB_details.tscn")
			Type.LAB_C:
				details_scene = load("res://scenes/tiles/details/laboratoryC_details.tscn")
			
	if (upgrade_menu == null):
		$UpgradeButton/Upgrade.frame = 4
		disabled_upgrade = true
	
	return self


func _on_info_button_pressed():
	var details : TileDetails
	if tile.type == Type.LAB_C:
		details = details_scene.instantiate().init(tile.health, floor(tile.money_gained))
	else:
		details = details_scene.instantiate().init(tile.health)
	world.add_child(details)
	self.slide_out()
	world.get_node("Validation").play()

func _on_upgrade_button_pressed():
	if not disabled_upgrade:
		var menu : Menu = upgrade_menu.instantiate().init(slot);
		world.add_child(menu)
		world.show_menu(menu)
		world.get_node("Validation").play()
	else:
		world.get_node("Cancel").play()

func _on_destroy_button_pressed():
	world.get_node("Cancel").play()
	tile.queue_free()
	self.slide_out()
