extends TextureFrame
var scenes = {	"MainMenu":preload("res://Scenes/MainMenu.tscn"),
				"InGame":preload("res://Scenes/InGame.tscn")
				}
export(String, "MainMenu", "InGame") var scene = "MainMenu"

func _ready():
	add_child(scenes[scene].instance())
	set_texture(get_node(scene).get_render_target_texture())