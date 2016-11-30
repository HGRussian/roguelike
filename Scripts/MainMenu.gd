extends Control


func _on_play_pressed():
	get_tree().get_current_scene().change_scene("InGame")


func _on_quit_pressed():
	get_tree().quit()
