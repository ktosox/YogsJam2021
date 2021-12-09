extends Button



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MenuButton_focus_entered():
	if !$Press.playing :
		$Select.pitch_scale = 0.9 + 0.08 * randf()
		$Select.play()
	pass # Replace with function body.


func _on_MenuButton_button_down():
	$Press.play()
	pass # Replace with function body.




func _on_MenuButton_mouse_entered():
	$Select.volume_db = -100
	pass # Replace with function body.


func _on_MenuButton_mouse_exited():
	$Select.volume_db = 0
	pass # Replace with function body.
