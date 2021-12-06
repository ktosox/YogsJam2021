extends KinematicBody2D

var bulletScene = preload("res://Actors/Attacks/Bullet.tscn")

const MAX_SPEED = 135

const ACCEL = 780

const FRICTION = 700

#const RANGE = 90

var impact = Vector2.ZERO

var movement = Vector2.ZERO

var team = true

var health = 1.0

var fireCooldown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if fireCooldown < 0.0:
			fire()
			fireCooldown = 0.35
#		$StabbeRang.attack_position(global_position + movement.normalized() * RANGE)

func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("ui_right") ) - int(Input.is_action_pressed("ui_left") )
	direction.y = int(Input.is_action_pressed("ui_down") ) - int(Input.is_action_pressed("ui_up") )
	direction = direction.normalized()
	direction *= delta * ACCEL
	movement = movement - ( movement / (FRICTION*delta) ) + direction
	movement = movement.clamped(MAX_SPEED)

	move_and_collide(( impact+movement)*delta,false)
	impact -= delta  * impact
	$Body.rotation = movement.angle()
	#$Camera2D.rotation = movement.angle() + PI*0.5
	modulate = GM.teamColor[team]
	modulate = modulate.darkened(1 - health)
	
	fireCooldown -= delta
	
	
	pass


func fire():
	var bullet = bulletScene.instance()
	var fireVec = $Body/Out.global_position - global_position
	fireVec = fireVec.normalized()
	bullet.rotation = fireVec.angle()
	bullet.global_position = $Body/Out.global_position
	bullet.linear_velocity = fireVec * 340
	bullet.team = team
	get_parent().add_child(bullet)
	pass

func bonk(attack:bool , damage = 1):
	if team == attack :
		health += 0.1 * damage
		health = min(health,1.0)
	else:
		health -= 0.1 * damage
		
	if health < 0.5 :
		die()
	pass

func die():
	queue_free()
	pass


func apply_impact(kick):
	impact += kick
	pass
