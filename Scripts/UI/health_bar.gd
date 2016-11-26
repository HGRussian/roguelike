extends Control

var RED = Color("#ac3232")

var bg_rect = Rect2(4,4,64,12)
var contur_rect = Rect2(5,5,62,10)
var sbg_rect = Rect2(6,6,60,8)
var line_rect = Rect2(7,7,58,6)

var font = preload ("res://Fonts/beefd_5_with_shadow.fnt")
var bg = preload ("res://Art/UI/health_bar/hb_bg.png")

var health = 2
var health_max = 4
var hp 

func _draw():
	draw_texture_rect(bg,bg_rect,true)
	draw_rect(Rect2(line_rect.pos, Vector2(line_rect.size.x/health_max*health,line_rect.size.y)), RED)
	
	hp = str(health)+"/"+str(health_max)
	draw_string(font, pos_text(hp, bg_rect), hp)

func pos_text(text, rect):
	var fs = font.get_string_size(text)
	var pos = rect.pos + Vector2((rect.size.x - fs.x)/2,(rect.size.y - fs.y)/2 + fs.y)
	return (pos).floor()