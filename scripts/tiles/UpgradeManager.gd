extends Node

const BaseTile = preload("res://scripts/tiles/BaseTile.gd")
const GeneratorTile = preload("res://scripts/tiles/GeneratorTile.gd")

var selected_tile : BaseTile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func select_tile(tile : BaseTile):
	self.selected_tile = tile
	if(tile is GeneratorTile):
		get_owner().show_menu($GeneratorUpgradeMenu)
