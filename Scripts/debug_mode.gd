extends Node2D

var debug_on = false
var font = preload ("res://Fonts/beefd_5_with_shadow.fnt")
onready var timer = get_node("up")
onready var player = get_node("../../objects/player")

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("debug_button"):
		if debug_on == true:
			timer.stop()
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			debug_on = false
		else:
			timer.start()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			debug_on = true
		update()
	if Input.is_action_just_pressed("debug_heath-"):
		player.health_current -= 1
	if Input.is_action_just_pressed("debug_heath+"):
		player.health_current += 1

func _draw():
	if debug_on:
		draw_string(font, Vector2(2,40), "FPS: "+str(OS.get_frames_per_second()))
		draw_string(font, Vector2(2,52), "Global mouse pos: " + str(get_tree().get_current_scene().get_viewport().get_mouse_pos()))
		draw_string(font, Vector2(2,58), "Mouse pos in InGAME viewport:"+str(get_local_mouse_pos()))
func _on_up_timeout():
	update()
