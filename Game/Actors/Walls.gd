extends TileMap


export var autoGen = false

export var param : int


export var sizeX = 20

export var sizeY = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if autoGen :
		
		generate_level()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_level():
	for t in get_used_cells():
		set_cellv(t,-1)
	for X in range(-sizeX,sizeX+1):
		for Y in range(-sizeY,sizeY+1):

	
			if int(round(sin(X*30)+ randi()%3 ))%2 and int(sin(Y)*7 )%2:
					set_cell(X,Y,0)
					
					update_bitmask_area( Vector2(X,Y) )
					set_cell(X,Y+1,0)
					update_bitmask_area( Vector2(X,Y+1) )
			if abs(X)<2 or abs(Y)<2 :
				set_cell(X,Y,-1)
				update_bitmask_area( Vector2(X,Y) )
			if abs(X)>sizeX-2 or abs(Y)>sizeY-2 :
				set_cell(X,Y,0)
				update_bitmask_area( Vector2(X,Y) )


	pass

