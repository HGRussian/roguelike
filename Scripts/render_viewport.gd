extends TextureFrame

func _ready():
	set_texture(get_node("MainMenu").get_render_target_texture())