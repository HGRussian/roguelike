extends Node2D

onready var tm_roof = get_parent().get_node("terrain/roof")
onready var bullet_spawn = get_node("bullet_spawn")
onready var anim = get_node("anim")
onready var cursor = get_node("../../../cursor")
onready var health_bar = get_node("../../UI/health_bar")

var bullet_ins = preload ("res://Scenes/bullet.tscn")

var current_anim = "idle_down"
var new_anim = "idle_down"
var walk = false
var go_anim

var walk_dir = Vector2(0,0)
var speed = 60

var health_current = 7
var health_max = 12


func _ready():
	health_bar.health = health_current
	health_bar.health_max = health_max
	randomize()
	anim.play(current_anim)
	set_process(true)

func _process(delta):
	#Стрельба
	bullet_spawn.set_pos((cursor.get_pos() - Vector2(160,120)).normalized())
	if (Input.is_action_just_pressed("shoot")):
		var b = bullet_ins.instance()
		b.vec = ((bullet_spawn.get_global_pos() - get_global_pos()).normalized()).rotated(randi()%10*0.01 * (randi()%2 - randi()%2))
		b.set_pos(bullet_spawn.get_global_pos())
		get_parent().get_node("player_bullets").add_child(b)
	
	#Движение
	walk_dir = Vector2(0,0)
	if (Input.is_action_pressed("ig_up") and tm_roof.get_cellv(tm_roof.world_to_map(get_pos().linear_interpolate( get_pos() + Vector2(0,-1)*speed,delta))) == -1):
		walk_dir.y = -1
	elif (Input.is_action_pressed("ig_down") and tm_roof.get_cellv(tm_roof.world_to_map(get_pos().linear_interpolate( get_pos() + Vector2(0,1)*speed,delta))) == -1):
		walk_dir.y = 1
	if (Input.is_action_pressed("ig_right") and tm_roof.get_cellv(tm_roof.world_to_map(get_pos().linear_interpolate( get_pos() + Vector2(1,0)*speed,delta))) == -1):
		walk_dir.x = 1
	elif (Input.is_action_pressed("ig_left") and tm_roof.get_cellv(tm_roof.world_to_map(get_pos().linear_interpolate( get_pos() + Vector2(-1,0)*speed,delta))) == -1):
		walk_dir.x = -1
		
	if (walk_dir.abs() == Vector2(1,1)):
		walk_dir = walk_dir*0.75
	var new_pos = get_pos().linear_interpolate( get_pos() + walk_dir*speed,delta)
	set_pos(new_pos)
	
	#Анимация
	if walk_dir != Vector2(0,0):
		walk = true
	elif (current_anim.begins_with("walk") or walk == true):
		current_anim = ""
		walk = false
	
	if (current_anim != new_anim):
		current_anim = new_anim
		anim.play(current_anim)
	
	if (bullet_spawn.get_pos().x < 0):
		if (bullet_spawn.get_pos().y > -0.5 and bullet_spawn.get_pos().y < 0.5):
			go_anim = "left"
	elif (bullet_spawn.get_pos().x > 0):
		if (bullet_spawn.get_pos().y > -0.5 and bullet_spawn.get_pos().y < 0.5):
			go_anim = "right"
	if (bullet_spawn.get_pos().y < 0):
		if (bullet_spawn.get_pos().x > -0.5 and bullet_spawn.get_pos().x < 0.5):
			go_anim = "up"
	elif (bullet_spawn.get_pos().y > 0):
		if (bullet_spawn.get_pos().x > -0.5 and bullet_spawn.get_pos().x < 0.5):
			go_anim = "down"
	
	newanim(go_anim)
	
	#UI. Health bar
	if health_current > health_max:
		health_current = health_max
	if health_current < 0:
		health_current = 0
	if (health_bar.health != health_current):
		health_bar.update()
		health_bar.health = health_current
	if (health_bar.health_max != health_max):
		health_bar.update()
		health_bar.health_max = health_max
		
func newanim(dir):
	if (dir != null):
		if walk:	new_anim = "walk_" + dir
		else:	new_anim = "idle_" + dir