extends Control
class_name Menu

enum SlideState {
	HIDDEN, SLIDEIN, SHOWN, SLIDEOUT
}

var state : SlideState = SlideState.HIDDEN
const SPEED : int = 60

func _process(delta):
	match(state):
		SlideState.SLIDEIN:
			if global_position.x < 0:
				global_position.x += delta * SPEED
			else:
				state = SlideState.SHOWN
				global_position.x = floor(global_position.x)
		SlideState.SLIDEOUT:
			if global_position.x > -12:
				global_position.x -= delta * SPEED
			else:
				state = SlideState.HIDDEN
				global_position.x = floor(global_position.x)
				get_node("/root/World").menu_hidden(self)

func slide_in():
	state = SlideState.SLIDEIN

func slide_out():
	state = SlideState.SLIDEOUT
