extends Node

var teamColor = {true : ColorN("Red"), false : ColorN("Blue")} 

var highScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_score()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func load_score():
	var save = File.new()
	if not save.file_exists("user://score.save"):
		print("no save file to load score")
		return
	save.open("user://score.save", File.READ)
	var score = int( save.get_as_text() )
	highScore = score
	save.close()
	pass

func save_score(score):
	var save = File.new()
	save.open("user://score.save", File.WRITE)
	save.store_string(String(score))
	save.close()
	pass
