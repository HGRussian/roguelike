extends Control

func _on_play_pressed():
	get_tree().get_current_scene().change_scene("InGame")

func _on_quit_pressed():
	get_tree().quit()

func _on_options_pressed():
	get_node("menu/main").hide()
	get_node("menu/options").show()

func _on_go_menu_pressed(s):
	get_node("menu/main").show()
	get_node("menu/"+s).hide()