extends Node2D

var min_spawn_rate = 1.0
var max_spawn_rate = 0.3
var cur_spawn_rate = min_spawn_rate
var dificuldade = 30.0
var spawn_time = 0.0
var game_time = 0.0
onready var spawn_points = $spawnpoints.get_children()

var corno = preload("res://cenas/atirador.tscn")
var navetirim = preload("res://cenas/inimigoquerealatira.tscn")

func _process(delta):
	game_time += delta
	var t = clamp(game_time/dificuldade,0.0,1.0)
	cur_spawn_rate = lerp (min_spawn_rate,max_spawn_rate,t)
	
	spawn_time += delta
	if spawn_time>cur_spawn_rate:
		spawn_time = 0.0
		spawn()


func spawn():
	for spawnpoint in spawn_points:
		if randi()%2 == 0:
			var enemy = null
			if randi()%2==0:
				 enemy = corno.instance()
			else:
				 enemy = navetirim.instance()
				
			get_tree().get_root().add_child(enemy)
			enemy.add_to_group("delete_on_restart")
			enemy.global_position = spawnpoint.global_position
			
			
	
	


