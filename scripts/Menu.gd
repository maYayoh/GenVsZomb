extends Control

enum SlideState {
	HIDDEN, SLIDEIN, SHOWN, SLIDEOUT
}

var state : SlideState = SlideState.HIDDEN
@onready var pos : float = position.x
const SPEED : int = 60

func _process(delta):
	match(state):
		SlideState.SLIDEIN:
			if position.x < 0:
				pos += delta * SPEED
			else:
				state = SlideState.SHOWN
				pos = floor(pos)
		SlideState.SLIDEOUT:
			if position.x > -12:
				pos -= delta * SPEED
			else:
				state = SlideState.HIDDEN
				pos = floor(pos)
				get_owner().menu_hidden(self)
	
	position.x = pos

func slide_in():
	state = SlideState.SLIDEIN

func slide_out():
	state = SlideState.SLIDEOUT
