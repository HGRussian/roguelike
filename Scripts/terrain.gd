extends Node2D

onready var roof = get_node("roof")
onready var walls = get_node("walls")
onready var ground = get_node("ground")

func _ready():
	randomize()
	gen(2000,0.7)

func gen(iter,radius):
	clear()
	var x = 0
	var y = 0
	var i = 0
	while i != iter:
		var dir = randi()%4
		if dir == 0:
			x+=1
		elif dir == 1:
			x-=1
		elif dir == 2:
			y+=1
		elif dir == 3:
			y-=1
		
		#circle_draw_build-in_func
		var f = 1 - radius
		var ddf_x = 1
		var ddf_y = -2 * radius
		var x_circle = 0
		var y_circle = radius
		set_cell(Vector2(x, y + radius))
		set_cell(Vector2(x, y - radius))
		set_cell(Vector2(x + radius, y))
		set_cell(Vector2(x - radius, y))
		while x_circle < y_circle:
			if f >= 0: 
				y_circle -= 1
				ddf_y += 2
				f += ddf_y
				x_circle += 1
				ddf_x += 2
				f += ddf_x    
				set_cell(Vector2(x + x_circle, y + y_circle))
				set_cell(Vector2(x - x_circle, y + y_circle))
				set_cell(Vector2(x + x_circle, y - y_circle))
				set_cell(Vector2(x - x_circle, y - y_circle))
				set_cell(Vector2(x + y_circle, y + x_circle))
				set_cell(Vector2(x - y_circle, y + x_circle))
				set_cell(Vector2(x + y_circle, y - x_circle))
				set_cell(Vector2(x - y_circle, y - x_circle))
			
		i+=1
	
	#smoothing
	for it in range(0,2):
		for x in range(-iter/20,iter/20):
			for y in range(-iter/20,iter/20):
				var cleaner = 0
				if ground.get_cell(x+1,y) == -1:
					cleaner+=1
				if ground.get_cell(x+1,y+1) == -1:
					cleaner+=1
				if ground.get_cell(x,y+1) == -1:
					cleaner+=1
				if ground.get_cell(x-1,y+1) == -1:
					cleaner+=1
				if ground.get_cell(x-1,y) == -1:
					cleaner+=1
				if ground.get_cell(x-1,y-1) == -1:
					cleaner+=1
				if ground.get_cell(x,y-1) == -1:
					cleaner+=1
				if ground.get_cell(x+1,y-1) == -1:
					cleaner+=1
				if cleaner <= 3:
					set_cell(Vector2(x,y))
	
	set_roof(Vector2(iter/10,iter/10))
	
	
func set_cell(pos):
	ground.set_cell(pos.x,pos.y,2)

func set_roof(size):
	var x_l = size.x/2-size.x
	var x_r = size.x/2
	var y_t = size.y/2-size.y
	var y_b = size.y/2
	for x in range(x_l,x_r):
		for y in range(y_t,y_b):
			if ground.get_cell(x,y) == 2:
				if ground.get_cell(x,y+1) == -1:
					roof.set_cell(x,y+1,0)
				if ground.get_cell(x+1,y) == -1:
					roof.set_cell(x+1,y,3)
				if ground.get_cell(x-1,y) == -1:
					roof.set_cell(x-1,y,3)
				if ground.get_cell(x,y-1) == -1:
					roof.set_cell(x,y-1,3)
					walls.set_cell(x,y-1,1)
				if ground.get_cell(x-1,y-1) == -1:
					roof.set_cell(x-1,y-1,3)
				if ground.get_cell(x+1,y-1) == -1:
					roof.set_cell(x+1,y-1,3)
				if ground.get_cell(x-1,y+1) == -1:
					roof.set_cell(x-1,y+1,3)
				if ground.get_cell(x+1,y+1) == -1:
					roof.set_cell(x+1,y+1,3)
			
			

func clear():
	roof.clear()
	walls.clear()
	ground.clear()