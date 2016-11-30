extends Control

func _ready():
	pass

func change_scene(new_scene):
	get_node("render").change(new_scene)