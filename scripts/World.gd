extends Node2D

const Menu = preload("res://scripts/Menu.gd")

var money : int = 10
var energy : int = 0
var day_number : int = 0

var shown_menu : Menu = null
var queued_menu : Menu = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


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
