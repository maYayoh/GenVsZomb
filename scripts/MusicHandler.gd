extends AudioStreamPlayer
class_name MusicHandler

enum MusicState {NONE, FADE_IN, FADE_OUT, INIT, DIE}

@export var state : MusicState = MusicState.NONE


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match(state):
		MusicState.NONE:
			pass
		MusicState.INIT:
			self.volume_db += 0.5
			if self.volume_db == -30:
				state = MusicState.NONE
		MusicState.FADE_IN:
			self.volume_db += 0.5
			if self.volume_db >= -15:
				state = MusicState.NONE
		MusicState.FADE_OUT:
			self.volume_db -= 0.5
			if self.volume_db <= -30:
				state = MusicState.NONE
		MusicState.DIE:
			self.volume_db -= 0.5
			if self.volume_db <= -50:
				self.stop()

func fade_in():
	state = MusicState.FADE_IN

func fade_out():
	state = MusicState.FADE_OUT

func die():
	state = MusicState.DIE
