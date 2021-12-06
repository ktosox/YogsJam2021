extends RigidBody2D

var health = 0.8

var team = false

var target : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	modulate = GM.teamColor[team]
	modulate = modulate.darkened(1 - health)
	pass

func bonk(attack:bool):
	if team == attack :
		health += 0.1
	else:
		health -= 0.1
		
	if health < 0.5 :
		die()
	pass


func die():
	$Body.queue_free()
	$CollisionShape2D.queue_free()
	$Particles2D.emitting = true
	$TimerDie.start()
	pass


func _on_TimerDie_timeout():
	call_deferred("queue_free")
	pass # Replace with function body.
