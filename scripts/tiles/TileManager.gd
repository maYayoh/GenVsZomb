extends Node2D

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
	if selected_slot != null:
		selected_slot.get_child(2).visible = false
	slot.get_child(2).visible = true
	self.selected_slot = slot
	get_owner().show_menu($"../BuildMenu")

func add_tile(tile_type : BuildButton.TileType):
	var node : Area2D = null

	match(tile_type):
		BuildButton.TileType.GENERATOR:
			node = GeneratorTile.instantiate()
		BuildButton.TileType.TOWER:
			node = TowerTile.instantiate()
		BuildButton.TileType.LABORATORY:
			node = LaboratoryTile.instantiate()
	
	selected_slot.add_building(node)
	selected_slot.get_child(2).visible = false
