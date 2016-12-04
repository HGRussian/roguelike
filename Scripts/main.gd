extends Control
var scenes = {	"MainMenu":preload("res://Scenes/MainMenu.tscn"),
				"InGame":preload("res://Scenes/InGame.tscn")}
export(String, "MainMenu", "InGame") var scene = "MainMenu"

func _ready():
	change(scene)

func change(new_scene):
	for c in get_children():
		c.queue_free()
	add_child(scenes[new_scene].instance())

func change_scene(new_scene):
	change(new_scene)