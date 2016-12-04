extends TextureFrame

var max_lenght = 112.0

func set_param (h_c, h_m, l_c, l_m, m_c, m_m):
	get_node("h").set_size(Vector2((max_lenght/h_m)*h_c,4))
	print (Vector2((max_lenght/l_m)*l_c,4))
	get_node("l").set_size(Vector2((max_lenght/l_m)*l_c,4))
	get_node("m").set_size(Vector2((max_lenght/m_m)*m_c,4))