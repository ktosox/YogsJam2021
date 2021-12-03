extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("ui_right") ) - int(Input.is_action_pressed("ui_left") )
	direction.y = int(Input.is_action_pressed("ui_down") ) - int(Input.is_action_pressed("ui_up") )
	direction = direction.normalized()
	
	move_and_collide(direction*50*delta,false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
