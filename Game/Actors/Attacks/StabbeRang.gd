extends Path2D




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack_position(glob_pos:Vector2):
	curve.clear_points()
	curve.add_point(Vector2.ZERO,Vector2(rand_range(-1,1)*10,rand_range(-1,1)*10),Vector2(rand_range(-1,1)*10,rand_range(-1,1)*10))
	curve.add_point(to_local(glob_pos).clamped(40).rotated(2 + randf()*2 ) )
	curve.add_point(to_local(glob_pos),Vector2(rand_range(-1,1)*10,rand_range(-1,1)*10),Vector2(rand_range(-1,1)*10,rand_range(-1,1)*10) )
	curve.add_point(Vector2.ZERO)
	$Animator.play("Attack")
	pass
