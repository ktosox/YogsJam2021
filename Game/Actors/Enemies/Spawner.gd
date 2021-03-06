extends "res://Actors/Enemies/Enemy.gd"

#var flyBoiScene = preload("res://Actors/Enemies/FlyBoi.tscn")

var swirlyBoiScene = preload("res://Actors/Enemies/SwirlyBoi.tscn")

var next = 0

var bois = []

var maxSpawn = 0

export var spawning = true

export var spawn_direction = Vector2(1,0)

func _ready():
	maxSpawn = 7 + round(GM.currentLevel/3)
	pass

func _kick_bucket():
	$AnimationPlayer.play("New Anim")
	$CollisionShape2D.queue_free()
	$Explode.play()
	get_tree().get_nodes_in_group("LEVEL")[0].update_progress()
	pass

func _on_Timer_timeout():
	for b in bois:
		if !is_instance_valid(b):
			bois.erase(b)
	if bois.size() > 3 or !spawning or maxSpawn < 1:
		return
	$Timer.wait_time += 0.08
	var nextBoi : RigidBody2D
#	if next%3 < 2:
	nextBoi = swirlyBoiScene.instance()
#	else:
#		nextBoi = flyBoiScene.instance()
	bois.push_back(nextBoi)
	maxSpawn -= 1
	next += 1
	nextBoi.team = team
	nextBoi.add_collision_exception_with(self)
	nextBoi.global_position = global_position
	get_parent().add_child(nextBoi)
	nextBoi.apply_central_impulse( (spawn_direction*6 + Vector2(rand_range(-1,1),rand_range(-1,1)) ) * 20 )
	pass # Replace with function body.

func _exit_tree():
	
	pass
