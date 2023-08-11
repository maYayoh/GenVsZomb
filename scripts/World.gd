extends Node2D

var money : int = 10
var energy : int = 0
var day_number : int = 0
var cursor_pos : Vector2 = Vector2.ZERO

var shown_menu : Menu = null
var queued_menu : Menu = null

func show_menu(menu : Menu):
	toggle_cursor(true)
	if shown_menu == null:
		shown_menu = menu
		shown_menu.slide_in()
	else:
		shown_menu.slide_out()
		queued_menu = menu

func menu_hidden(menu : Menu):
	if shown_menu == menu:
		if queued_menu != null:
			shown_menu = queued_menu
			shown_menu.slide_in()
			queued_menu = null
		else:
			shown_menu = null
			toggle_cursor(false)
	else:
		push_error("Currently saved menu and just hidden menu were different!")


func _on_update_ressource(money, energy):
	self.money -= money
	self.energy -= energy
	
	if self.money > 99: self.money = 99
	if self.energy > 99: self.energy = 99
	
	if money != 0:
		$"./RessourcesMenu/MoneyHolder/DizainM".set_frame(self.money / 10)
		$"./RessourcesMenu/MoneyHolder/UnitM".set_frame(self.money % 10)
	if energy != 0:
		$"./RessourcesMenu/EnergyHolder/DizainE".set_frame(self.energy / 10)
		$"./RessourcesMenu/EnergyHolder/UnitE".set_frame(self.energy % 10)
	
#	print("Money : " + str(self.money) + "\tEnergy : " + str(self.energy))

func toggle_cursor(show : bool):
	$SelectedTile.position = cursor_pos - Vector2(7,7)
	$SelectedTile.visible = show

func check_building_energy():
	pass
	
