extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func explode():
	for n in get_overlapping_bodies():
		if n.has_method("bonk"):
			var dummy = load("res://Actors/Enemies/Dummy.tscn").instance()
			dummy.team = !n.team
			n.bonk(dummy,10)
	pass

func _on_Animator_animation_finished(anim_name):

	queue_free()
	pass # Replace with function body.
