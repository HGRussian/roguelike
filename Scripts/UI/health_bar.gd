extends Control

var GREEN = Color("#4abe30")
var bg_rect = Rect2(4,4,72,12)
var sbg_rect = Rect2(4,16,64,8)
var sline_rect = Rect2(6,19,60,2)

var font = preload ("res://Fonts/beefd_5_with_shadow.fnt")
var bg = preload ("res://Art/UI/health_bar/hb_empty.png")
var hh = preload ("res://Art/UI/health_bar/hb.png")
var sbg = preload ("res://Art/UI/health_bar/sb_bg.png")

var health = 2
var health_max = 4

var score = 22
var score_max = 30

var hp 
var level = 5

func _draw():
	#Health bar
	draw_texture_rect(bg,Rect2(bg_rect.pos,Vector2(health_max*6,12)),true)
	draw_texture_rect(hh,Rect2(bg_rect.pos,Vector2(health*6,12)),true)
	#Score bar
	draw_texture_rect(sbg,sbg_rect,true)
	draw_rect(Rect2(sline_rect.pos, Vector2(sline_rect.size.x/score_max*score,sline_rect.size.y)), GREEN)
	draw_string(font, pos_text(str(level), sbg_rect), str(level))

func pos_text(text, rect):
	var fs = font.get_string_size(text)
	var pos = rect.pos + Vector2((rect.size.x - fs.x)/2,(rect.size.y - fs.y)/2 + fs.y)
	return (pos).floor()