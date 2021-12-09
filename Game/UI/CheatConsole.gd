extends Control

var donconScene = preload("res://Actors/Special/Doncon.tscn")

var boomScene = preload("res://Actors/Special/Boom.tscn")

var lastCheat : String

var maxLines = 5

var cheatsUnlocked = true

var active = false

var gameOver = false

var eggList = {
	"YES" : "NO",
	"NO" : "YES",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel") and !$Animator.is_playing() and !gameOver:
		if active :
			$Animator.play("hide")
			get_tree().paused = false
		else:
			get_tree().paused = true
			$Input.clear()
			$Animator.play("show")
	if $Input.has_focus() and event.is_action_pressed("ui_up"):
		if lastCheat != null :
			$Input.text = lastCheat

			

func process_command(text:String):
	var command = text.split(" ")[0]
	command = command.to_upper()
	if eggList.has(command) :
		$Output.text = "> " + eggList[command] + '\n' + $Output.text
	else:
		match command :
			"REDMATTER":
				if get_tree().get_nodes_in_group("BOOM").empty():
					add_boom()
				else:
					$Output.text = "> " + "BOMB NOT READY" + '\n' + $Output.text
			"DONCON" :
				if get_tree().get_nodes_in_group("DONCON").empty():
					add_doncon()
				else:
					$Output.text = "> " + "DONCON NOT READY" + '\n' + $Output.text
				pass
			_:
				$Output.text = "> NO SUCH COMMAND AS "+ command+ '\n' + $Output.text
	pass

func add_boom():
	lastCheat = "REDMATTER"
	var newBoom = boomScene.instance()
	var target = get_tree().get_nodes_in_group("PLAYER")[0]
	newBoom.global_position = target.global_position
	target.get_parent().add_child(newBoom)
	$Output.text = "> " + "BOMB DEPLOYED!" + '\n' + $Output.text
	pass

func add_doncon():
	lastCheat = "DONCON"
	var newDon = donconScene.instance()
	var target = get_tree().get_nodes_in_group("PLAYER")[0]
	newDon.global_position = target.global_position
	newDon.global_rotation = target.global_rotation
	target.get_parent().add_child(newDon)
	$Output.text = "> " + "DONCON DEPLOYED!" + '\n' + $Output.text
	pass

func _on_Input_text_entered(new_text):
	$Output.text = new_text + '\n' + $Output.text
	if cheatsUnlocked :
		process_command(new_text)
	else:
		$Output.text = "> YOU NEED TO UNLOCK CHEATS FIRST" + '\n' + $Output.text



	$Input.clear()
	$Output.update()
	pass # Replace with function body.


func _on_Animator_animation_finished(anim_name):
	if anim_name == "show":
		
		$Input.grab_focus()
	active = !active
	pass # Replace with function body.




func _on_Output_focus_entered():
	$Input.grab_focus()
	pass # Replace with function body.
