extends Node2D

onready var roof = get_node("roof")
onready var walls = get_node("walls")
onready var ground = get_node("ground")
onready var shadow = get_node("shadow")

onready var ui = get_node("../../ui")

var stage = 0
var i = 0
var x = 0
var y = 0

var size = 2000.0

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	if stage < 2:
		gen(size,0.7)
		ui.load_bg.set_size(Vector2((i/size*100)/1.73,6))
		ui.load_text.set_text("Generating...")
	elif stage == 2:
		create_texture(0)
		ui._end_gen()
		stage+=1
		
	

func create_texture(type):
	# ХЗ
	if type == 0:
		# Потолок
		var roof_tex = ImageTexture.new()
		var roof_color = Color("#8f563b")
		
		var image = Image(10,10,false,4)
		for i in range (0,10):
			for j in range (0,10):
				var chance  = 0.0
				for q in range(0,12):
					chance+=(randi()%1001)*0.001
				chance-=6
				if chance > 0:
					var offset = randf()/25
					image.put_pixel(i,j,Color(roof_color.r-offset,roof_color.g-offset,roof_color.b-offset))
				else:
					var offset = randf()/25
					image.put_pixel(i,j,Color(roof_color.r-offset,roof_color.g-offset,roof_color.b-offset,0))
				
		for i in range (1,9):
			for j in range (1,9):
				var offset = randf()/25
				image.put_pixel(i,j,Color(roof_color.r-offset,roof_color.g-offset,roof_color.b-offset))
		
		roof_tex.create_from_image(image)
		roof_tex.set_flags(0)
		roof.get_tileset().tile_set_texture(3,roof_tex)
		roof.get_tileset().tile_set_region(3, Rect2(0,0,10,10))
		roof.get_tileset().tile_set_texture(0,roof_tex)
		roof.get_tileset().tile_set_region(0, Rect2(0,0,10,10))
		# Пол
		var ground_tex = ImageTexture.new()
		var ground_color = Color ("#d9a066")
		
		var image = Image(8,8,false,3)
		for i in range (0,8):
			for j in range (0,8):
				var offset = randf()/50
				image.put_pixel(i,j,Color(ground_color.r-offset,ground_color.g-offset,ground_color.b-offset))
		
		ground_tex.create_from_image(image)
		ground_tex.set_flags(0)
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
		wall_tex.set_flags(0)
		roof.get_tileset().tile_set_texture(1,wall_tex)
		roof.get_tileset().tile_set_region(1, Rect2(0,0,8,8))
		
		for i in range(0,8):
			var shadow_tex = ImageTexture.new()
			image = Image(16,16,false,4)
			for j in range(0,16):
				for k in range(0,16):
					var saturation = 16-abs(j-8)-abs(k-8)
					if randi()%16 < saturation:
						image.put_pixel(j,k,Color(0,0,0))
					else:
						image.put_pixel(j,k,Color(0,0,0,0))
			shadow_tex.create_from_image(image)
			shadow_tex.set_flags(0)
			shadow.get_tileset().tile_set_texture(i,shadow_tex)
			shadow.get_tileset().tile_set_region(i,Rect2(0,0,16,16))

func gen(iter,radius):
	if i == 0:
		clear()
		stage = 0
		x = 0
		y = 0
	if i < iter:
		for q in range(0,32):
			var dir = randi()%4
			if dir == 0:
				x+=1
			if dir == 1:
				x-=1
			if dir == 2:
				y+=1
			if dir == 3:
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
				
			i=ground.get_used_cells().size()
	elif stage == 0:
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
		print("Smoothed...")
		stage+=1
	if stage == 1:
		var cells = ground.get_used_cells()
		var y_t = cells[0].y-5
		var y_b = cells[cells.size()-1].y+5
		cells.sort()
		var x_l = cells[0].x-5
		var x_r = cells[cells.size()-1].x+5
		set_roof(x_l,x_r,y_t,y_b)
		stage+=1
		print("ready!")
	
	
func set_cell(pos):
	ground.set_cell(pos.x,pos.y,2)

func set_roof(x_l,x_r,y_t,y_b):
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
						shadow.set_cell(x,y,randi()%8)
					

func clear():
	roof.clear()
	walls.clear()
	ground.clear()
	shadow.clear()