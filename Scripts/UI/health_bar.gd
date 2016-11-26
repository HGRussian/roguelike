extends Control

var WHITE = Color(1,1,1)
var BLACK = Color(0,0,0)
var RED = Color("#ac3232")

#var pos = Vector2(2,2)
#var size = Vector2 (56, 11)
#var pos_line = Vector2(5,5)
#var size_line = Vector2(51,6)

var bg_rect = Rect2(4,4,64,12)
var contur_rect = Rect2(5,5,62,10)
var sbg_rect = Rect2(6,6,60,8)
var line_rect = Rect2(7,7,58,6)

var font = preload ("res://Fonts/beefd_5_with_shadow.fnt")

var health = 2
var health_max = 4

var hp 

func _draw():
	draw_rect(bg_rect, BLACK)
	draw_rect(contur_rect,WHITE)
	draw_rect(sbg_rect, BLACK)
	
	draw_rect(Rect2(line_rect.pos, Vector2(line_rect.size.x/health_max*health,line_rect.size.y)), Color (1,0,0))
	
	hp = str(health)+"/"+str(health_max)
	draw_string(font, pos_text(hp, sbg_rect), hp)

func pos_text(text, rect):
	var pos = Vector2((rect.size.x - font.get_string_size(text).x)/2,font.get_string_size(text).y)
	return (pos + rect.pos).floor()