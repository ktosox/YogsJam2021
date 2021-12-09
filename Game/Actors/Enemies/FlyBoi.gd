extends "res://Actors/Enemies/Enemy.gd"


var targetOffset = 0.0

var bulletScene = preload("res://Actors/Attacks/ShortBullet.tscn")

onready var guns = [$Body/SquareRound,$Body/SquareRound2]

var cooldown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func _physics_process(delta):
	targetOffset += delta
	cooldown -= delta
	if target != null:
		if is_instance_valid(target):
			var desiredPos = target.global_position
			var targetingVec = (target.global_position - global_position).normalized() 
			rotation = targetingVec.angle()
			var offsetVec = Vector2(sin(targetOffset*2)*100,abs(cos(targetOffset*0.7)) *50)
			
			desiredPos+= offsetVec.rotated(targetOffset*0.2)#.rotated(targetingVec.angle())
			desiredPos -= targetingVec * 120
			linear_velocity = (desiredPos-global_position).clamped(120) 
			if cooldown < 0.0 :
				fire()
			pass
		else:
			target = null
	pass

func fire():
	cooldown = 0.7
	var bullet = bulletScene.instance()
	bullet.team = team
	bullet.global_position = guns[0].global_position
	bullet.apply_central_impulse((target.global_position - global_position).normalized() * 120 )
	bullet.add_collision_exception_with(self)
	bullet.rotation = (target.global_position - global_position).normalized().angle()
	guns.invert()
	get_parent().add_child(bullet)
	pass

func _kick_bucket():
	cooldown = 6000
	$Body.queue_free()
	$Particles2D.emitting = true
	$CollisionShape2D.queue_free()
	$Death.play()
	pass







func _on_DetectionZone_body_entered(body):
	if body.team != team :
		target = body
	pass # Replace with function body.
