extends "res://Actors/Enemies/Enemy.gd"


var moveCooldown = 0.0

# Called when the node enters the scene tree for the first time.



func _physics_process(delta):
	moveCooldown -= delta
	if target != null:
		if is_instance_valid(target):
			if moveCooldown < 0.0 :
				moveCooldown = 1.07
				var direction = target.global_position - global_position
				direction = direction.normalized()
				apply_central_impulse(direction * 700 * (1.6-randf()) )
				$Move.play()
				
		else:
			target = null
	
	pass


func _kick_bucket():

	moveCooldown = 500
	$Move.stop()
	$Move.call_deferred("queue_free")
	$CollisionShape2D.call_deferred("queue_free")
	$Body.visible = false
	$Death.play()
	$Particles2D.emitting = true
	pass

func _on_SwirlyBoi_body_entered(body):
	if body.has_method("bonk") and body.team != team:
		body.bonk(self,health)
		die()
		
	pass # Replace with function body.


func _on_DetectionZone_body_entered(body):
	if body.team != team :
		target = body
	pass # Replace with function body.


