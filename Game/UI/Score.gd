extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var zeroes = "00000000"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_score(0)
	pass # Replace with function body.


func get_score():
	return int(bbcode_text)

func set_score(score):
	bbcode_text = "[center]" + String(score).pad_zeros(14)
	pass

func add_points(points):
	var currentPoints = int(bbcode_text)
	currentPoints += points
	set_score(currentPoints)

	
	pass
