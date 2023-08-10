extends Node2D

var money : int = 10
var energy : int = 0
var day_number : int = 0

var shown_menu : Menu = null
var queued_menu : Menu = null

func show_menu(menu : Menu):
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
	else:
		push_error("Currently saved menu and just hidden menu were different!")


func _on_update_ressource(money, energy):
	self.money -= money
	self.energy -= energy
	print("Money : " + str(self.money) + "\tEnergy : " + str(self.energy))
