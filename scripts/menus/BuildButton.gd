extends TextureButton
class_name BuildButton

enum TileType {
	GENERATOR, TOWER, LABORATORY
}

const GeneratorTile = preload("res://scenes/tiles/gen_tile.tscn")
const TowerTile = preload("res://scenes/tiles/tour_tile.tscn")
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
			tile_type = TowerTile.instantiate()
		TileType.LABORATORY:
			tile_type = LaboratoryTile.instantiate()
	
	if get_parent().state == Menu.SlideState.SHOWN:
		if $"../..".money >= tile_type.money_cost:
			$"../../Validation".play()
			$"../../TileManager".add_tile(tile_type)
			get_parent().slide_out()
		else:
			$"../../Cancel".play()
			%RessourcesMenu.shake(%RessourcesMenu/MoneyHolder)
