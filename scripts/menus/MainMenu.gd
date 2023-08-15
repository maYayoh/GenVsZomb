extends Control

const tutorial = preload("res://scenes/menus/tutoriel.tscn")

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_tutorial_pressed():
	add_child(tutorial.instantiate())
