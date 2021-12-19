extends Area2D


export var team = true


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = GM.teamColor[team]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TeamShifter_body_entered(body):
	if body.has_method("update_team"):
		body.update_team(team)
	pass # Replace with function body.
