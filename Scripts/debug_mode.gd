extends Node2D

var debug_on = false
var font = preload ("res://Fonts/beefd_5.fnt")
onready var timer = get_node("up")
onready var player = get_tree().get_current_scene().get_node("objects/player")

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("debug_button"):
		if debug_on == true:
			timer.stop()
			debug_on = false
		else:
			timer.start()
			debug_on = true
		print ("Debug is "+str(debug_on))
		update()
	if Input.is_action_just_pressed("debug_heath-"):
		player.health_current -= 1
	if Input.is_action_just_pressed("debug_heath+"):
		player.health_current += 1

func _draw():
	if debug_on:
		draw_string(font, Vector2(2,20), "FPS: "+str(OS.get_frames_per_second()))

func _on_up_timeout():
	update()
