extends Node2D
class_name TileManager

signal update_ressources(money, energy)

enum TileType {
	GEN, GEN_A, GEN_B, GEN_C,
	TOUR, TOUR_A, TOUR_B, TOUR_C,
	LAB, LAB_A, LAB_B, LAB_C,
	NULL
}

const GenMenu = preload("res://scenes/menus/clicks/gen_click_menu.tscn")
const TourMenu = preload("res://scenes/menus/clicks/tour_click_menu.tscn")
const LabMenu = preload("res://scenes/menus/clicks/lab_click_menu.tscn")
const DefaultMenu = preload("res://scenes/menus/clicks/default_click_menu.tscn")

var selected_slot : TileSlot = null
@onready var world : World = get_owner()


func on_day(): # a déclencher lors de fin de vague
	for slot in get_children():
		slot.on_day()

func on_night(): # signal a recevoir d'un bouton
	for slot in get_children():
		slot.on_night()


func select_slot(slot : TileSlot):
	self.selected_slot = slot
	world.show_menu($"../BuildMenu")

func look_menu(slot: TileSlot, type : TileType):
	self.selected_slot = slot
	var menu : LookMenu = null
	match(type):
		TileType.GEN:
			menu = GenMenu.instantiate().init(selected_slot)
		TileType.TOUR:
			menu = TourMenu.instantiate().init(selected_slot)
		TileType.LAB:
			menu = LabMenu.instantiate().init(selected_slot)
		_:
			menu = DefaultMenu.instantiate().init(selected_slot)
	world.add_child(menu)
	world.show_menu(menu)


func add_tile(node : BaseTile):
	selected_slot.add_building(node)


func energy_check(safe : bool):
	for slot in get_children():
		slot.energy_check(safe)
