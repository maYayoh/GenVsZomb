extends TextureButton

enum TileType {
	GENERATOR, TOWER, LABORATORY
}

const Menu = preload("res://scripts/Menu.gd")
@export var type : TileType

func _ready():
	pressed.connect(on_click)

func on_click():
	if get_parent().state == Menu.SlideState.SHOWN:
		$"../../TileManager".add_tile(type)
		get_parent().slide_out()
