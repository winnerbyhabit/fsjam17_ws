extends TileMap

#scene-variables
export(int) var distance = 15
export(int) var width = 40
export(int) var height = 30
export(int) var tilesize = 32
export(int) var pathes = 5 #pathes without obstacles
export(int) var wall_x = 25 #walls oriated parallel to x-axis
export(int) var wall_y = 33 #walls oriated parallel to y-axis
export(int) var wall_x_max_len = 13
export(int) var wall_y_max_len = 10
export(Vector2) var start
export(Vector2) var exit
var map = {}

signal ready
signal hero_wins

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	generateMap()
	
func generateMap():
	# random Start and Exit points at least distance tiles away from each other
	randomize() #new randomseed
	
	map = {}
	# init map with borderwalls
	for i in range(width):
		map[Vector2(i, 0)] = 1
		map[Vector2(i,height-1)] = 1
	
	for j in range(height):
		map[Vector2(0,j)] = 1
		map[Vector2(width-1,j)] = 1
	
	
	# place $(wall_x) walls parallel to x-axis
	var walls = []
	for i in range(wall_x):
		#random y position of wall
		var temp = randi()%(height-walls.size())
		while(walls.has(temp)):
			temp += 1
		walls.append(temp)
		
		var len = randi()%wall_x_max_len #random lenght of wall
		var offset = randi()%(width-len) #space between side and wall
		for j in range(len):
			map[Vector2(j+offset,temp)] = 1
	
	# place $(wall_y) walls parallel to y-axis
	walls = []
	for i in range(wall_y):
		#random x position of wall
		var temp = randi()%(width-walls.size())
		while(walls.has(temp)):
			temp += 1
		walls.append(temp)
		
		var len = randi()%wall_y_max_len #random lenght of wall
		var offset = randi()%(height-len) # space between top and wall
		for j in range(len):
			map[Vector2(temp,j+offset)] = 1
	
	
	
	
	# start
	var start_x = (randi()%(width-2))+1
	var start_y = (randi()%(height-2))+1
	
	start = Vector2(start_x,start_y)
	
	# first pick exit_y cause width>height and you can pic bigger distance
	var exit_y = (randi()%(height-2))+1
	
	var dif_y = start_y-exit_y 
	if (dif_y<0):
		dif_y = -dif_y 
	var exit_x
	if (dif_y>=distance): # check trivial case
		exit_x = randi()%width
	else:
		var min_dif_x = distance - dif_y # dif_x + dif_y = distance
		var temp_range = width-2 # alias all cells that can be choosen
		var flag = 0 # changes flag if start is close to wall
		if(start_x<=min_dif_x):
			temp_range += -start_x - min_dif_x
			flag = 1 # start is near 0
		elif((start_x+min_dif_x)>=width):
			temp_range += -start_x - min_dif_x
			flag = 2 # start is near width
		else:
			temp_range += -(2*min_dif_x)
			
		exit_x = (randi()%temp_range)+1
		if(flag==1):
			exit_x += start_x + min_dif_x
		elif(exit_x >= (start_x-min_dif_x)):
				exit_x += (2*min_dif_x)
	exit = Vector2(exit_x,exit_y)
	
	get_node("tuer").set_pos(Vector2(exit_x*tilesize,exit_y*tilesize))
	#map[Vector2(start_x,start_y)] = 2
	#map[Vector2(exit_x,exit_y)] = 3
	
	
	
	var e0 = Vector2(1,0)
	var e1 = Vector2(0,1)
	#generate $(pathes) ways between start and exit with no wall
	for i in range(pathes):
		print(start)
		var point = start
		while(point!=exit):
				var temp = randi()%2
				
				if(((temp==0)and(point.x!=exit.x))or((temp==1)and(point.y==exit.y))):
					if(point.x<exit.x):
						point += e0
					else: 
						point -= e0
				else:
					if(point.y<exit.y):
						point += e1
					else:
						point -= e1
					
				if(map.has(point)):
					map.erase(point)
	
	
	for i in range(width):
		for j in range(height):
			var key = Vector2(i,j)
			if (map.has(key)):
				set_cell(i,j,1)
			else:
				set_cell(i,j,0)
	#connect("ready",get_parent(),"set_start")
	print(start)
	emit_signal("ready")





func get_start():
	return start*tilesize

func get_exit():
	return exit * tilesize

func hit_exit( body ):
	if(body.is_in_group("hero")):
		emit_signal("hero_wins")
	pass # replace with function body
	
func placeWall(pos):
	if(map.has(pos)):
		return false
	else:
		map[pos] = 1
		set_cell(pos.x,pos.y,1)
		return true
