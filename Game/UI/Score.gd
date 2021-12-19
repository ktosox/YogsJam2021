extends RichTextLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(GM.currentScore)
	pass # Replace with function body.


func get_score():
	return int(bbcode_text)

func set_score(score):
	bbcode_text = "[center]" + String(score).pad_zeros(10)
	pass

func add_points(points):
	GM.currentScore += points
	set_score(GM.currentScore)

	
	pass
