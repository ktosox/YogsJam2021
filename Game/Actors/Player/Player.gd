extends KinematicBody2D

var bulletScene = preload("res://Actors/Attacks/Bullet.tscn")

const MAX_SPEED = 135

const ACCEL = 780

const FRICTION = 700

#const RANGE = 90

var fightMode = false

var impact = Vector2.ZERO

var movement = Vector2.ZERO

var team = true

var health = 1.0

var fireCooldown = 0.0

var fireRate = 0.27

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("shoot") and fightMode:
		if fireCooldown < 0.0:
			fire()
			
			fireCooldown = fireRate
	if event.is_action_pressed("shift") and !$Body/AnimationPlayer.is_playing():
		
		if !fightMode :
			$Transform.pitch_scale = 0.6
			$Transform.play()
			$Body/AnimationPlayer.play("Fight")
		else:
			$Transform.pitch_scale = 0.8
			$Transform.play()
			$Body/AnimationPlayer.play_backwards("Fight")
		
#		$StabbeRang.attack_position(global_position + movement.normalized() * RANGE)

func _physics_process(delta):
	if dead :
		return
	var direction = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("ui_right") ) - int(Input.is_action_pressed("ui_left") )
	direction.y = int(Input.is_action_pressed("ui_down") ) - int(Input.is_action_pressed("ui_up") )
	direction = direction.normalized()
	if fightMode :
		pass
	else:
		if direction.y < 0 :
			direction*=1.6
		if direction.x != 0:
			direction.x *= 0.2
			rotate(direction.x*delta*12)
	direction = direction.rotated(rotation)
	direction *= delta * ( ACCEL + 500*int(!fightMode))
	movement = movement - ( movement / (FRICTION*delta) ) + direction
	movement = movement.clamped(MAX_SPEED + 520*int(!fightMode))
	
	$Woosh.pitch_scale = ( 100 + movement.length() ) / 200
	move_and_collide(( impact+movement)*delta,false)
	impact -= delta  * impact
	#$Body.rotation = movement.angle()
	#$Camera2D.rotation = movement.angle() + PI*0.5
	modulate = GM.teamColor[team]
	modulate = modulate.darkened(1 - health)
	
	fireCooldown -= delta
	if fireCooldown < 0.0 :
		$Body/Ring/CircleSmall.visible = true
	
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
	$Body/Ring/CircleSmall.visible = false
	$Shoot.pitch_scale = (randf() + 8)/4.5
	$Shoot.play()
	pass

func bonk(attack:bool , damage = 1):
	if team == attack :
		health += 0.1 * damage
		health = min(health,1.0)
	else:
		$Damage.play()
		health -= 0.1 * damage
		
	if health < 0.25 :
		die()
	pass

func die():
	dead = true
	$CollisionShape2D.queue_free()
	$Camera2D/Label/AnimationPlayer.play("New Anim")
	$Body.visible = false
	pass

func back_to_menu():
	get_tree().change_scene("res://UI/MainMenu.tscn")
	pass

func apply_impact(kick):
	impact += kick
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	fightMode = !fightMode
	pass # Replace with function body.
