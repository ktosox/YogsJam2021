extends RigidBody2D

var team
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.


func _physics_process(delta):
	linear_velocity  += linear_velocity.normalized() * delta * 170


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.


func _on_ShortBullet_body_entered(body):
	if body.has_method("bonk"):
		body.bonk(self)
	call_deferred("queue_free")
	pass # Replace with function body.
