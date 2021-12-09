extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var zeroes = "00000000"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_points(points):
	var currentPoints = int(bbcode_text)
	currentPoints += points

	bbcode_text = "[center]" + String(currentPoints).pad_zeros(10)
	
	pass
