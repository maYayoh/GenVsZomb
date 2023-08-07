extends Area2D

var tile : Area2D = null

func _ready():
	$Selected.visible = false

func add_building(node : Area2D):
	tile = node
	add_child(tile)

func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && tile == null):
		get_parent().select_slot(self)
