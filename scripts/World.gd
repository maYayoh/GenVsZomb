extends Node2D
class_name World

var money : int = 10
var energy : int = 0
var day_number : int = 0
var is_night : bool = false
var safe_to_go : bool = true
var cursor_pos : Vector2 = Vector2.ZERO

var shown_menu : Menu = null
var queued_menu : Menu = null

const Warning = preload("res://scenes/warning.tscn")


func on_day():
	is_night = false
	check_building_energy()
	$DayNightCycle.play("NewDay")
	$TileManager.on_day()
	$RessourcesMenu.on_day()

func on_night():
	is_night = true
	day_number += 1
	$DayNightCycle.play("NewNight")
	$TileManager.on_night()
	$ZombieManager.on_night()
	$RessourcesMenu.on_night()


func show_menu(menu : Menu, show_cursor : bool = true):
	toggle_cursor(show_cursor)
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
		
		if (menu is LookMenu):
			menu.queue_free()
	else:
		push_error("Currently saved menu and just hidden menu were different!")


func _on_update_ressource(money, energy):
	self.money -= money
	self.energy -= energy
	
	if self.money > 99: self.money = 99
	if self.energy > 99: self.energy = 99
	
	if money != 0:
		%DizainM.set_frame(self.money / 10)
		%UnitM.set_frame(self.money % 10)
	if energy != 0:
		%DizainE.set_frame((10) if self.energy < 0 else abs(self.energy / 10))
		%UnitE.set_frame((10) if self.energy < -9 else abs(self.energy % 10))
	
	$RessourcesMenu.update_states(money != 0, energy != 0)
	
	if not is_night:
		check_building_energy()
	
#	print("Money : " + str(self.money) + "\tEnergy : " + str(self.energy))


func toggle_cursor(show : bool):
	$SelectedTile.position = cursor_pos - Vector2(7,7)
	$SelectedTile.visible = show

func check_building_energy():
	if $Buttons/NightButton/NightIcon.get_child_count() == 1:
		$Buttons/NightButton/NightIcon.get_child(0).queue_free()
	
	if self.energy < 0:
		safe_to_go = false
		
		var warning : Sprite2D = Warning.instantiate()
		$Buttons/NightButton/NightIcon.add_child(warning)
	else:
		safe_to_go = true
	
	$TileManager.energy_check(Warning, safe_to_go)


func _on_night_panel_pressed():
	if !is_night:
		if $Buttons.state == Menu.SlideState.HIDDEN:
			show_menu($Buttons, false)
		else:
			$Buttons.slide_out()

func _on_night_button_pressed():
	if safe_to_go:
		$Buttons.slide_out()
		on_night()
	else:
		$RessourcesMenu.shake($RessourcesMenu/EnergyHolder)

func _on_lab_button_pressed():
	$Buttons.slide_out()


func _process(_delta):
	if Input.is_action_just_pressed("ui_focus_next") && $ZombieManager.get_child_count() > 1:
		$ZombieManager.get_child(1).queue_free()
