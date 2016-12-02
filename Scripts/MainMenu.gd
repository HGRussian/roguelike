extends Control


func _on_play_pressed():
	get_tree().get_current_scene().change_scene("InGame")


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_node("ui/main").hide()
	get_node("ui/options").show()


func _on_go_menu_pressed(s):
	get_node("ui/main").show()
	get_node("ui/"+s).hide()
