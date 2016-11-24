extends Node2D

onready var bullet_spawn = get_node("bullet_spawn")
var bullet_ins = preload ("res://Scenes/bullet.tscn")
onready var anim = get_node("anim")
var current_anim = "idle_down"
var new_anim = "idle_anim"
var walk = false
var walk_dir = Vector2(0,0)
var speed = 60

func _ready():
	anim.play(current_anim)
	set_process(true)
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(get_pos() + walk_dir*speed*delta)

func _process(delta):
	print (bullet_spawn.get_pos())
	bullet_spawn.set_pos((get_global_mouse_pos()-get_global_pos()).normalized())
	if (Input.is_action_just_pressed("shoot")):
		var b = bullet_ins.instance()
		b.vec = (bullet_spawn.get_global_pos() - get_global_pos()).normalized()
		b.set_pos(bullet_spawn.get_global_pos())
		get_parent().get_node("player_bullets").add_child(b)
	
	walk_dir = Vector2 (0,0)
	if (Input.is_action_pressed("ui_up")):
		walk_dir.y = -1
	if (Input.is_action_pressed("ui_down")):
		walk_dir.y = 1
	if (Input.is_action_pressed("ui_right")):
		walk_dir.x = 1
	if (Input.is_action_pressed("ui_left")):
		walk_dir.x = -1
	
	if (walk_dir.abs() == Vector2(1,1)):
		walk_dir = walk_dir*0.75
	
	if walk_dir != Vector2(0,0):
		walk = true
	else:
		current_anim = ""
		walk = false
	
	
	if (bullet_spawn.get_pos().x < 0):
		if (bullet_spawn.get_pos().y > -0.5 and bullet_spawn.get_pos().y < 0.5):
			newanim("left")
	elif (bullet_spawn.get_pos().x > 0):
		if (bullet_spawn.get_pos().y > -0.5 and bullet_spawn.get_pos().y < 0.5):
			newanim("right")
	if (bullet_spawn.get_pos().y < 0):
		if (bullet_spawn.get_pos().x > -0.5 and bullet_spawn.get_pos().x < 0.5):
			newanim("up")
	elif (bullet_spawn.get_pos().y > 0):
		if (bullet_spawn.get_pos().x > -0.5 and bullet_spawn.get_pos().x < 0.5):
			newanim("down")
	
	if (current_anim != new_anim):
		current_anim = new_anim
		anim.play(current_anim)
		
func newanim(dir):
	if walk:
		new_anim = "walk_" + dir
	else:
		new_anim = "idle_" + dir