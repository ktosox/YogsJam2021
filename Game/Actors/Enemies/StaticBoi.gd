extends "res://Actors/Enemies/Enemy.gd"

var bulletScene = preload("res://Actors/Attacks/BouncyBullet.tscn")

var cooldown = 0.0


func _physics_process(delta):
	cooldown -= delta
	if target != null:
		if is_instance_valid(target):
			if $DetectionZone.get_overlapping_bodies().has(target):
				var angleVec = target.global_position - global_position
				$Line2D.rotation = angleVec.angle()
				if cooldown < 0.0:
					fire()
					cooldown = 0.95
		else:
			target = null
				
	pass

func fire():
	var bullet = bulletScene.instance()
	bullet.global_position = $Line2D/Out.global_position
	var angleVec = $Line2D/Out.global_position - global_position
	angleVec = angleVec.normalized()
	bullet.add_collision_exception_with(self)
	bullet.apply_central_impulse(angleVec*130)
	bullet.team = team
	get_parent().add_child(bullet)
	pass



func _on_DetectionZone_body_entered(body):
	if body.team != team :
		target = body
	pass # Replace with function body.
