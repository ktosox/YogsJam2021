extends RigidBody2D


var team = false



# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bullet_body_entered(body):
	if body.has_method("bonk"):
		body.bonk(self)
	call_deferred("queue_free")
	pass # Replace with function body.
