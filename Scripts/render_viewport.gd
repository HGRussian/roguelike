extends TextureFrame

func _ready():
	set_texture(get_node("InGame").get_render_target_texture())