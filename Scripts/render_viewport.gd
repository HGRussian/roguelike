extends TextureFrame

var viewport

func _ready():
	viewport = get_node("InGame")
	set_texture(viewport.get_render_target_texture())
