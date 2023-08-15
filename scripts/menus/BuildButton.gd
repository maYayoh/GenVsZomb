extends TextureButton
class_name BuildButton

enum TileType {
	GENERATOR, TOWER, LABORATORY
}

const GeneratorTile = preload("res://scenes/tiles/gen_tile.tscn")
const TowerTileScene = preload("res://scenes/tiles/tour_tile.tscn")
const LaboratoryTile = preload("res://scenes/tiles/lab_tile.tscn")

@export var type : TileType

func _ready():
	pressed.connect(on_click)

func on_click():
	var tile_type : BaseTile
	match(type):
		TileType.GENERATOR:
			tile_type = GeneratorTile.instantiate()
		TileType.TOWER:
			tile_type = TowerTileScene.instantiate()
		TileType.LABORATORY:
			tile_type = LaboratoryTile.instantiate()
	
	if get_parent().state == Menu.SlideState.SHOWN:
		if $"../..".money >= tile_type.money_cost:
			$"../../TileManager".add_tile(tile_type)
			get_parent().slide_out()
		else:
			%RessourcesMenu.shake(%RessourcesMenu/MoneyHolder)
