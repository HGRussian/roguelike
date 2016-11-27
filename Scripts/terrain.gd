extends Node2D

onready var roof = get_node("roof")
onready var walls = get_node("walls")
onready var ground = get_node("ground")
onready var shadow = get_node("shadow")

func _ready():
	randomize()
	gen(2000,0.7)
	create_texture(0)

func create_texture(type):
	# ХЗ
	if type == 0:
		# Потолок
		var roof_tex = ImageTexture.new()
		var roof_color = Color("#8f563b")
		
		var image = Image(8,8,false,3)
		for i in range (0,8):
			for j in range (0,8):
				image.put_pixel(i,j,roof_color)
		
		roof_tex.create_from_image(image)
		roof_tex.set_flags(3)
		roof.get_tileset().tile_set_texture(3,roof_tex)
		roof.get_tileset().tile_set_region(3, Rect2(0,0,8,8))
		roof.get_tileset().tile_set_texture(0,roof_tex)
		roof.get_tileset().tile_set_region(0, Rect2(0,0,8,8))
		# Пол
		var ground_tex = ImageTexture.new()
		var ground_color = Color ("#d9a066")
		for i in range (0,8):
			for j in range (0,8):
				image.put_pixel(i,j, ground_color)
		
		ground_tex.create_from_image(image)
		ground_tex.set_flags(3)
		roof.get_tileset().tile_set_texture(2,ground_tex)
		roof.get_tileset().tile_set_region(2, Rect2(0,0,8,8))
		# Стены
		var wall_tex = ImageTexture.new()
		var wall_color = Color ("#696a6a")
		image = Image(8,8,false,4)
		var wall_points_color = Color("#847e87")
		var roof_points = [2,4,5]
		var ground_points = [2,3,7]
		for i in range (0,8):
			for j in range (0,4):
				if (j == 0 and (roof_points.find(i) != -1)):
					image.put_pixel(i,j,roof_color)
				elif (j == 3 and (ground_points.find(i) != -1)):
					image.put_pixel(i,j,ground_color)
				elif (randi()%2 == 0):
					image.put_pixel(i,j, wall_points_color)
				else:
					image.put_pixel(i,j,wall_color)
			for j in range (4,8):
				if (j<7):
					image.put_pixel(i,j,Color(0,0,0,0.1))
				elif (j == 7 and (roof_points.find(i) != -1)):
					image.put_pixel(i,j,Color(0,0,0,0.1))
		
		wall_tex.create_from_image(image)
		wall_tex.set_flags(3)
		roof.get_tileset().tile_set_texture(1,wall_tex)
		roof.get_tileset().tile_set_region(1, Rect2(0,0,8,8))

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
	for x in range(x_l,x_r):
		for y in range(y_t,y_b):
			if roof.get_cell(x,y) == -1:
				if (roof.get_cell(x,y+1) != -1 or
				 roof.get_cell(x,y-1) != -1 or
				 roof.get_cell(x+1,y) != -1 or
				 roof.get_cell(x-1,y) != -1 or
				 roof.get_cell(x-1,y-1) != -1 or
				 roof.get_cell(x+1,y-1) != -1 or
				 roof.get_cell(x+1,y+1) != -1 or
				 roof.get_cell(x-1,y+1) != -1):
					if ground.get_cell(x,y) == -1:
						shadow.set_cell(x,y,0)
					
					
			

func clear():
	roof.clear()
	walls.clear()
	ground.clear()
	shadow.clear()