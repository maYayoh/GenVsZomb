extends Menu
class_name UpgradeMenu

var slot : TileSlot = null
@export var upgradeA : PackedScene = null
@export var upgradeB : PackedScene = null
@export var upgradeC : PackedScene = null

func init(slot : TileSlot) -> Menu:
	self.slot = slot
	return self

func button_clicked(scene : PackedScene):
	var tile : BaseTile = scene.instantiate()
	
	if self.state == Menu.SlideState.SHOWN:
		if get_parent().money >= tile.money_cost:
			slot.change_building(tile)
			self.slide_out()
		else:
			$"../RessourcesMenu".shake($"../RessourcesMenu/MoneyHolder")



func _on_upgrade_a_button_pressed():
	if upgradeA != null:
		button_clicked(upgradeA)
	else:
		push_error("Upgrade A of " + name + " is not set.")

func _on_upgrade_b_button_pressed():
	if upgradeB != null:
		button_clicked(upgradeB)
	else:
		push_error("Upgrade B of " + name + " is not set.")

func _on_upgrade_c_button_pressed():
	if upgradeC != null:
		button_clicked(upgradeC)
	else:
		push_error("Upgrade C of " + name + " is not set.")
