extends "res://Actors/Enemies/Enemy.gd"

var flyBoiScene = preload("res://Actors/Enemies/FlyBoi.tscn")

var swirlyBoiScene = preload("res://Actors/Enemies/SwirlyBoi.tscn")

var next = 0

var bois = []

func _kick_bucket():
	$AnimationPlayer.play("New Anim")
	$CollisionShape2D.queue_free()
	pass

func _on_Timer_timeout():
	for b in bois:
		if !is_instance_valid(b):
			bois.erase(b)
	if bois.size() > 5 :
		return
	$Timer.wait_time += 0.08
	var nextBoi : RigidBody2D
	if next%3 < 1:
		nextBoi = swirlyBoiScene.instance()
	else:
		nextBoi = flyBoiScene.instance()
	bois.push_back(nextBoi)
	next += 1
	nextBoi.team = team
	nextBoi.add_collision_exception_with(self)
	nextBoi.global_position = global_position
	get_parent().add_child(nextBoi)
	nextBoi.apply_central_impulse(-global_position.normalized() * 600 )
	pass # Replace with function body.
