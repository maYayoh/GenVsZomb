extends Menu
class_name LookMenu

@onready var world = get_node("/root/World")
@export var details_scene : PackedScene = null
@export var upgrade_menu : PackedScene = null
var disabled_upgrade : bool = false
var slot : TileSlot

func init(slot : TileSlot) -> LookMenu:
	if (details_scene == null):
		push_error(self.name + " don't have a details scene.")
	if (upgrade_menu == null):
		$UpgradeButton/Upgrade.set_frame(4)
		disabled_upgrade = true
	
	self.slot = slot
	return self

func _on_info_button_pressed():
	var details : TileDetails = details_scene.instantiate().init(slot.get_child(2).health)
	world.add_child(details)
	self.slide_out()

func _on_upgrade_button_pressed():
	if not disabled_upgrade:
		var menu : Menu = upgrade_menu.instantiate();
		world.add_child(menu)
		world.show_menu(menu)

func _on_destroy_button_pressed():
	slot.get_child(2).queue_free()
	self.slide_out()
