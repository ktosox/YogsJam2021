extends TabContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sound/Sound.grab_focus()
	$Sound/Effects.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))
	$Sound/Music.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	$Sound/Sound.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sound_value_changed(value):
	if(value == -40):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master") ,true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master") ,false)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master") ,value)
	pass # Replace with function body.


func _on_Effects_value_changed(value):
	if(value == -40):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects") ,true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects") ,false)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects") ,value)
	pass # Replace with function body.


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music") ,value)
	if(value == -40):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music") ,true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music") ,false)
	pass # Replace with function body.
