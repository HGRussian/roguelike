extends Node

var aspect = 1
var new_aspect = 1

#func _ready():
#	set_process(true)
#
#func _process(delta):
#	if (OS.get_window_size().x/320 > OS.get_window_size().y/240):
#		new_aspect = 3
#	elif (OS.get_window_size().x/320 < OS.get_window_size().y/240):
#		new_aspect = 2
#	
#	if new_aspect != aspect:
#		aspect = new_aspect
#		get_tree().set_screen_stretch(2,aspect,Vector2(320,240))
