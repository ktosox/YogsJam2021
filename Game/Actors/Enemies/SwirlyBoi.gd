extends RigidBody2D


var team = false


var health = 0.7

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.


func _physics_process(delta):
	modulate = modulate.darkened(1 - health)
	pass


func _on_SwirlyBoi_body_entered(body):
	if body.has_method("bonk"):
		body.bonk(team)
		call_deferred("queue_free")
	pass # Replace with function body.
