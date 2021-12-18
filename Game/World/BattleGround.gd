extends Node2D

var progress_tracker = 0

var GUI = preload("res://UI/GUI.tscn")


var floor_layouts = [
	preload("res://World/Layouts/Level1.tscn"),
#	preload("res://World/Layouts/Level2.tscn"),
#	preload("res://World/Layouts/Level3.tscn"),
	
]


# Called when the node enters the scene tree for the first time.
func _ready():
	next_level()
	pass # Replace with function body.


func next_level():
	if has_node("GUI"):
		$GUI.queue_free()
	load_level()
	GM.currentLevel += 1
	
	pass

func load_level():
	#$Curtain/VBoxContainer/AnimationPlayer.play("Load")
	add_GUI()
	var new_layout = floor_layouts[GM.currentLevel%3]
	$ViewportContainer/Viewport.add_child(new_layout.instance())
	progress_tracker = 3
	get_tree().paused = false
	pass

func add_GUI():
	add_child(GUI.instance())
	pass

func end_level():
	get_tree().paused = true
	$Curtain/VBoxContainer/AnimationPlayer.play("End")
	pass

func update_progress():
	progress_tracker -= 1
	if progress_tracker < 1:
		end_level()
	else:
		print(progress_tracker," targets remain")
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Load" :
		add_GUI()
	pass # Replace with function body.
