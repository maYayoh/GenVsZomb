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
			if position.x < 0:
				position.x += delta * SPEED
			else:
				state = SlideState.SHOWN
				position.x = floor(position.x)
		SlideState.SLIDEOUT:
			if position.x > -12:
				position.x -= delta * SPEED
			else:
				state = SlideState.HIDDEN
				position.x = floor(position.x)
				get_node("/root/World").menu_hidden(self)

func slide_in():
	state = SlideState.SLIDEIN

func slide_out():
	state = SlideState.SLIDEOUT
