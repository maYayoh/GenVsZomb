extends Menu

func _process(delta):
	match(state):
		SlideState.SLIDEIN:
			if position.y > 52:
				position.y -= delta * SPEED
			else:
				state = SlideState.SHOWN
				position.y = ceil(position.y)
		SlideState.SLIDEOUT:
			if position.y < 64:
				position.y += delta * SPEED
			else:
				state = SlideState.HIDDEN
				position.y = ceil(position.y)
				$"..".menu_hidden(self)
