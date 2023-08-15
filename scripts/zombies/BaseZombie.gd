extends Area2D
class_name BaseZombie

enum ZombieType {SMALL_ZOMBIE, TALL_ZOMBIE, BIG_ZOMBIE}


signal attack(Zombie : BaseZombie)
signal death()

const hit_sound : AudioStream = preload("res://assets/sounds/zombie_hit.wav")
const death_sound : AudioStream = preload("res://assets/sounds/zombie_death.wav")

@export var type : ZombieType
@export var health : int = 10
@export var power : int = 1
@export var time_between_moves : float = 1.0
@export var money_gained : int = 1
@export var attack_sound : AudioStream

@onready var audio : AudioStreamPlayer = $AudioStreamPlayer

var active : bool = false
var primed : bool = false
var initial_wait : float = 0


func _ready():
	$Timer.wait_time = time_between_moves
	initial_wait = randf_range(0, time_between_moves)
	print(initial_wait)
	audio.finished.connect(_on_audio_stream_player_finished)
	death.connect(on_death)

func _process(delta):
	if initial_wait > 0:
		initial_wait -= delta
	elif not active:
		active = true
		$Timer.start()

func take_damage(damageAmount):
	if active:
		health -= damageAmount
		if (health <= 0):
			death.emit()
		else:
			audio.stream = hit_sound
			audio.play()

func _on_timer_timeout():
	if active:
		if primed:
			attack.emit(self)
			audio.stream = attack_sound
			audio.play()
			position.y -= 1
			await get_tree().process_frame
			position.y += 1
		else:
			position.x += 1

func on_death():
	audio.stop()
	audio.stream = death_sound
	audio.play()
	(get_parent() as ZombieManager).update_ressources.emit(-money_gained, 0)

func _on_hurt_box_area_entered(area):
	if(area is BaseTile):
		primed = true
		attack.connect(area.on_damage)

func _on_hurt_box_area_exited(area):
	if(area is BaseTile):
		primed = false
		attack.disconnect(area.on_damage)


func _on_audio_stream_player_finished():
	if(audio.stream == death_sound):
		queue_free()
