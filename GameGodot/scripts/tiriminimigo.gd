extends KinematicBody2D

const velocidade = 300
const life_time = 5
var cur_life = 0.0
var dir = Vector2.DOWN

func _physics_process(delta):
	var colisao = move_and_collide(dir*delta*velocidade)
	if colisao and colisao.collider.has_method("kill"):
		colisao.collider.kill()
		queue_free()
	
	cur_life+=delta
	if cur_life>life_time:
		queue_free()
