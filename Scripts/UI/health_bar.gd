extends Control

var pos = Vector2(2,2)
var size = Vector2 (56, 11)
var pos_line = Vector2(4,4)
var size_line = Vector2(52,7)

var font = preload ("res://Fonts/beefd_5.fnt")

var health = 6
var health_max = 8 

func _draw():
	draw_rect(Rect2(pos, size), Color (0.8,0.8,0.8))
	draw_rect(Rect2(pos_line, size_line), Color (0.65,0.65,0.65))
	draw_rect(Rect2(pos_line, Vector2(size_line.x/health_max*health,size_line.y)), Color (1,0,0))
	draw_string(font, Vector2(20,11), str(health)+"/"+str(health_max))