extends Control


func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))

func _on_master_value_changed(value):
	set_volume(0, value)


func _on_music_value_changed(value):
	set_volume(1, value)


func _on_fx_value_changed(value):
	set_volume(2, value)


func _on_fx_toggled(toggled_on):
	if toggled_on == true:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)

func _on_music_toggled(toggled_on):
	if toggled_on == true:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)


func _on_master_toggled(toggled_on):
	if toggled_on == true:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
