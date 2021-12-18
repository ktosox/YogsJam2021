extends Node2D


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
	
	GM.currentLevel += 1
	load_level()
	pass

func load_level():
	#$Curtain/VBoxContainer/AnimationPlayer.play("Load")
	var new_layout = floor_layouts[GM.currentLevel%3]
	$ViewportContainer/Viewport.add_child(new_layout.instance())
	pass

func add_GUI():
	add_child(GUI.instance())
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Load" :
		add_GUI()
	pass # Replace with function body.
