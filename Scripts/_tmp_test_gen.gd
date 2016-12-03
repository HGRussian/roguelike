extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	gen()
	
func gen():
	var roof_tex = ImageTexture.new()
	var roof_color = Color("#8f563b")
	
	var image = Image(10,10,false,4)
	var ch_arr = []
	for i in range (0,10):
		for j in range (0,10):
			var chance  = 0.0
			for q in range(0,12):
				chance+=(randi()%1001)*0.001
			chance-=6
			ch_arr.append(chance)
			#ch_arr.sort()
			print(chance)
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
	set_texture(roof_tex)
	

func _on_Button_pressed():
	gen()
