extends KinematicBody2D

const velocidade = 400
const life_time = 5
var cur_life = 0.0
var scoreboard = null

func _physics_process(delta):
	var colisao = move_and_collide(Vector2.UP*delta*velocidade)
	if colisao and colisao.collider.has_method("kill"):
		colisao.collider.kill()
		queue_free()
		scoreboard.add_point()
	
	cur_life+=delta
	if cur_life>life_time:
		queue_free()
	
