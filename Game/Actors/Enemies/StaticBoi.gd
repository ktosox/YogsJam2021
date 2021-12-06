extends RigidBody2D

var team = false

var bulletScene = preload("res://Actors/Attacks/BouncyBullet.tscn")

var fireCooldown = 0.0

var target:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.

func _physics_process(delta):
	fireCooldown -= delta
	if target != null :
		if $DetectionZone.get_overlapping_bodies().has(target):
			var angleVec = target.global_position - global_position
			$Line2D.rotation = angleVec.angle()
			if fireCooldown < 0.0:
				fire()
				fireCooldown = 2.35
	elif $DetectionZone.get_overlapping_bodies().size() > 0:
		target = $DetectionZone.get_overlapping_bodies()[0]
				
	pass

func fire():
	var bullet = bulletScene.instance()
	bullet.global_position = $Line2D/Out.global_position
	var angleVec = $Line2D/Out.global_position - global_position
	angleVec = angleVec.normalized()
	bullet.apply_central_impulse(angleVec*130)
	bullet.team = team
	get_parent().add_child(bullet)
	pass

