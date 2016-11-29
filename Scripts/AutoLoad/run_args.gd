extends Node

var first_boot = 0

func _ready():
	var args = OS.get_cmdline_args()
	for arg in args:
		if arg == "-nobootlogo":
			Globals.set("custom_params/start_boot_anim",0)
	
