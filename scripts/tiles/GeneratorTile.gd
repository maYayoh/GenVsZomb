extends GeneratorBase
class_name GeneratorTile

func _init():
	super(30, 2, 4)


func on_click(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		upgrade_menu()

func upgrade_menu():
	$"../../../UpgradeManager".select_tile(self)
