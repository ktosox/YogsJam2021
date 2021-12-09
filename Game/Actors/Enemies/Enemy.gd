extends RigidBody2D

export var health = 1.0

export var death = 0.5

export var armor = 0.1

export var team = false

export var points = 0

var target : Node2D

var timerDeath : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_team()
	pass # Replace with function body.

func update_team():
	modulate = GM.teamColor[team]
	modulate = modulate.darkened(1 - health)
	pass


func bonk(caller, damage = 1):
	var attack = caller.team
	if team == attack :
		health += armor * damage
		health = min(health,1.0)
	else:
		health -= armor * damage
	update_team()
	if health <= death :
		die()
		if caller.is_in_group("SCORE"):
			get_tree().get_nodes_in_group("SCOREBOARD")[0].add_points(points)
			print("SCORE")

	pass


func _kick_bucket():
	print("oops, the death stuff was not overwritten")
	pass

func die():
	_kick_bucket() # makes the character play the death anim and hide stuff, also get rid of colision
	#adds death timer
	timerDeath = Timer.new()
	timerDeath.connect("timeout",self,"queue_free")
	timerDeath.one_shot = true
	timerDeath.autostart = true
	timerDeath.wait_time = 2.0
	add_child(timerDeath)

	pass
