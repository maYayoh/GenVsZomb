extends Node2D
class_name TileManager

signal update_ressource(money, energy)

const GeneratorTile = preload("res://scenes/tiles/generator_tile.tscn")
const TowerTile = preload("res://scenes/tiles/tower_tile.tscn")
const LaboratoryTile = preload("res://scenes/tiles/laboratory_tile.tscn")

var selected_slot : TileSlot = null

func on_day(): # a déclencher lors de fin de vague
	for slot in get_children():
		slot.on_day()

func on_night(): # signal a recevoir d'un bouton
	for slot in get_children():
		slot.on_night()

func select_slot(slot : TileSlot):
	self.selected_slot = slot
	get_owner().show_menu($"../BuildMenu")

func add_tile(tile_type : BuildButton.TileType):
	var node : BaseTile = null

	match(tile_type):
		BuildButton.TileType.GENERATOR:
			node = GeneratorTile.instantiate()
		BuildButton.TileType.TOWER:
			node = TowerTile.instantiate()
		BuildButton.TileType.LABORATORY:
			node = LaboratoryTile.instantiate()
	
	update_ressource.emit(node.money_cost, node.energy_cost)
	
	selected_slot.add_building(node)
