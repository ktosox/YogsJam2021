extends KinematicBody2D


const MAX_SPEED = 135

const ACCEL = 780

const FRICTION = 700

#const RANGE = 90

var impact = Vector2.ZERO

var movement = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _input(event):
#	if event.is_action_pressed("ui_cancel"):
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
	pass

func apply_impact(kick):
	impact += kick
	pass
