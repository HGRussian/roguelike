extends Node2D

onready var roof = get_node("roof")
onready var walls = get_node("walls")
onready var ground = get_node("ground")

func _ready():
	clear()
	gen()
	set_roof(Vector2(50,50))

func gen():
	for i in range(-5,5):
		for j in range(-5,5):
			set_cell(Vector2(i,j))




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
					walls.set_cell(x,y-6,1)
				
	
	
func clear():
	roof.clear()
	walls.clear()
	ground.clear()