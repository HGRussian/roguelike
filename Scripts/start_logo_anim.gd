extends Control

var text = ["Team Name Ink. \n2016",
			"Created on \nGodot engine",
			"ubludok, mat tvoy, a ny idi suda govno sobachie, reshil ko mne lest. Ti, zasranec vonuchii, mat tvoy, a? Ny idi cyda, poprobyi menia trahnyt, ia teby sam trahny ybludok, onanist chertov, byd ti prokliat, idi idiot, trahat tebia i vsy tvoy semiu, govno sobachie, zhlob vonichii, derimo, syka, padla, idi cuda, merzavec, negodyai, gad, idi cuda ti - govno, JOPA!"
			]
onready var anim_player = get_node("start_anim")
onready var label = get_node("Label")
var current_text = 0

func next_text():
	if (current_text <= text.size()-1):
		label.set_text(text[current_text])
		return true
	else:
		return false

func _ready():
	next_text()

func _on_start_anim_finished():
	current_text += 1
	if (next_text()):
		if label.get_text().length() < 30:
			anim_player.play("show")
		else:
			anim_player.play("show_long")
	else:
		hide()
		get_node("../menu").show()
	
	if current_text == text.size()-1:
		get_node("load_anim_sprite").show()
