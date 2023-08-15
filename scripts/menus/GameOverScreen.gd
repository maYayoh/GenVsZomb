extends TextureButton

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")


func _on_audio_stream_finished():
	$AudioStream.volume_db -= 5
	if $AudioStream.volume_db > -50:
		$AudioStream.play()
