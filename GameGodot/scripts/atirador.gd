extends KinematicBody2D

var velocidade = 200
var explodiu = preload("res://cenas/pludiu.tscn")
const life_time = 5
var cur_life = 0.0

func _physics_process(delta):
	var colisao = move_and_collide(Vector2.DOWN*delta*velocidade)
	if colisao and colisao.collider.has_method("kill"):
		colisao.collider.kill()
	cur_life+=delta
	if cur_life>life_time:
		queue_free()

func kill():
	var expl = explodiu.instance()
	get_tree().get_root().add_child(expl)
	expl.global_position = global_position
	queue_free()
