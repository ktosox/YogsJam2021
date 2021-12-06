extends Control

var maxLines = 5

var cheatsUnlocked = true

var eggList = {
	"YES" : "NO",
	"NO" : "YES",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_down"):
		if !$Animator.is_playing():
			$Animator.play("show")
	if event.is_action_pressed("ui_cancel"):
		$Animator.play("hide")
			

func process_command(text:String):
	var command = text.split(" ")[0]
	command = command.to_upper()
	if eggList.has(command) :
		$Output.text = "> " + eggList[command] + '\n' + $Output.text
	else:
		match command :

			_:
				$Output.text = "> NO SUCH COMMAND AS "+ command+ '\n' + $Output.text
	pass


func _on_Input_text_entered(new_text):
	$Output.text = new_text + '\n' + $Output.text
	if cheatsUnlocked :
		process_command(new_text)
	else:
		$Output.text = "> YOU NEED TO UNLOCK CHEATS FIRST" + '\n' + $Output.text
	#I'll have to make it clear later, but not today
#	if $Output.get_line_count() > maxLines:
#		var lines = $Output.text.split('\n') 
#		lines.resize(maxLines)
#		var linecounter = 0
#
#		for z in lines:
#			$Output.set_line(linecounter,z)
#			linecounter+=1
#		pass


	$Input.clear()
	$Output.update()
	pass # Replace with function body.


func _on_Animator_animation_finished(anim_name):
	if anim_name == "show":
		$Input.grab_focus()
	pass # Replace with function body.
