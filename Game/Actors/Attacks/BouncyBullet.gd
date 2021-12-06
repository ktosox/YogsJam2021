extends RigidBody2D


var team = false


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BouncyBullet_body_entered(body):
	if body.has_method("bonk"):
		body.bonk(team)
		call_deferred("queue_free")
	pass # Replace with function body.


func _on_TimerDie_timeout():
	queue_free()
	pass # Replace with function body.
