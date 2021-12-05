extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func explode():
	$AnimationPlayer.play("New Anim")
	pass


func _on_TimerTest_timeout():
	explode()
	pass # Replace with function body.


func _on_Explosion_body_entered(body):
	if body.is_class("KinematicBody2D"):
		var kickVec = body.global_position - global_position
		var power = 140 * (40/kickVec.length())
		kickVec = kickVec.normalized()
		body.apply_impact(kickVec * power )
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
