extends RigidBody2D


export var team = false

var target:Node2D

var health = 1.0

var moveCooldown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.


func _physics_process(delta):
	modulate = modulate.darkened(1 - health)
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

func die():
	$TimerDie.start()
	pass


func bonk(attack, damage = 0.2):
	pass

func _on_SwirlyBoi_body_entered(body):
	if body.has_method("bonk"):
		body.bonk(team)
		call_deferred("queue_free")
	pass # Replace with function body.


func _on_DetectionZone_body_entered(body):
	if body.team != team :
		target = body
	pass # Replace with function body.


func _on_TimerDie_timeout():
	queue_free()
	pass # Replace with function body.
