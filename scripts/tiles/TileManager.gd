extends Node2D
class_name TileManager

signal update_ressources(money, energy)

enum TileType {
	GEN, GEN_A, GEN_B, GEN_C,
	TOUR, TOUR_A, TOUR_B, TOUR_C,
	LAB, LAB_A, LAB_B, LAB_C
}

const GenMenu = preload("res://scenes/menus/gen_click_menu.tscn")
const GenAMenu = preload("res://scenes/menus/genA_click_menu.tscn")
const GenBMenu = preload("res://scenes/menus/genB_click_menu.tscn")
const GenCMenu = preload("res://scenes/menus/genC_click_menu.tscn")
const TourMenu = preload("res://scenes/menus/tour_click_menu.tscn")
const TourAMenu = preload("res://scenes/menus/tourA_click_menu.tscn")
const TourBMenu = preload("res://scenes/menus/tourB_click_menu.tscn")
const TourCMenu = preload("res://scenes/menus/tourC_click_menu.tscn")

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
		TileType.GEN_A:
			menu = GenAMenu.instantiate().init(selected_slot)
		TileType.GEN_B:
			menu = GenBMenu.instantiate().init(selected_slot)
		TileType.GEN_C:
			menu = GenCMenu.instantiate().init(selected_slot)
		
		TileType.TOUR:
			menu = TourMenu.instantiate().init(selected_slot)
		TileType.TOUR_A:
			menu = TourAMenu.instantiate().init(selected_slot)
		TileType.TOUR_B:
			menu = TourBMenu.instantiate().init(selected_slot)
		TileType.TOUR_C:
			menu = TourCMenu.instantiate().init(selected_slot)
	world.add_child(menu)
	world.show_menu(menu)


func add_tile(node : BaseTile):
	selected_slot.add_building(node)
	update_ressources.emit(node.money_cost, node.energy_cost)


func energy_check(Warning : PackedScene, safe : bool):
	for slot in get_children():
		slot.energy_check(Warning, safe)
