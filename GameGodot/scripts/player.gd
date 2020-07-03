extends KinematicBody2D

const velocidade = 250
const fire_rate = 0.3
var fire_time = 0.0
var morto = false
var explodiu = preload("res://cenas/pludiu.tscn")

var laser_bolt = preload("res://cenas/laser.tscn")

func _ready():
	add_to_group("Player")

func _physics_process(delta):
	if morto:
		return
	var move_direction = Vector2()
	if Input.is_action_pressed("ui_left"):
		move_direction.x -=1
	if Input.is_action_pressed("ui_right"):
		move_direction.x +=1
	if Input.is_action_pressed("ui_up"):
		move_direction.y -=1
	if Input.is_action_pressed("ui_down"):
		move_direction.y +=1
	move_and_collide(move_direction*delta*velocidade)

func _process(delta):
	if Input.is_action_just_pressed("sair"):
		get_tree().quit()
	if morto and Input.is_action_just_pressed("recomeçar"):
		get_tree().call_group("delete_on_restart", "queue_free")
		get_tree().reload_current_scene()
	if not morto and Input.is_action_just_pressed("atirar"):
		shoot()


func shoot():
	if get_time()-fire_time<fire_rate:
		return
	fire_time = get_time()
	var las = laser_bolt.instance()
	get_tree().get_root().add_child(las)
	las.global_position = $firepoint.global_position
	las.scoreboard = $CanvasLayer/Score
	
	

func kill():
	morto = true
	$"CanvasLayer/recomeçar".show()
	var expl = explodiu.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	$Sprite.hide()
	

func get_time():
	return OS.get_ticks_msec()/1000.0
