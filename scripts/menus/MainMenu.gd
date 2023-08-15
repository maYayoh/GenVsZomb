extends TextureRect


const Zomb = preload("res://scenes/zombies/mainmenu_zombie.tscn")
const State = Menu.SlideState

var state : State = State.HIDDEN
const SPEED : int = 60

func _process(delta):
	match(state):
		State.SLIDEIN:
			if $Credits.position.y > 45:
				$Credits.position.y -= delta * SPEED
			else:
				state = State.SHOWN
				$Credits.position.y = ceil($Credits.position.y)
		State.SLIDEOUT:
			if $Credits.position.y < 64:
				$Credits.position.y += delta * SPEED
			else:
				state = State.HIDDEN
				$Credits.position.y = ceil($Credits.position.y)


const tutorial = preload("res://scenes/menus/tutoriel.tscn")

func _on_play_pressed():
	$Click.play()
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_tutorial_pressed():
	$Click.play()
	add_child(tutorial.instantiate())


func _on_credits_button_pressed():
	$Click.play()
	state = State.SLIDEIN

func _on_close_pressed():
	$Click.play()
	state = State.SLIDEOUT

func _on_mayayoh_pressed():
	$Click.play()
	OS.shell_open("https://mayayoh.itch.io")


func _on_coco_3167_pressed():
	$Click.play()
	OS.shell_open("https://coco3167.itch.io")


func _on_nihilaeth_pressed():
	$Click.play()
	OS.shell_open("https://www.nihilaeth.com")


func _on_lab_pressed():
	$Click.play()
	$Interactive.add_child(Zomb.instantiate())
