extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

var health = 3
var player_inattack_zone = false

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		velocity = (player.get_global_position() - position).normalized() * speed * delta
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		velocity = lerp(velocity, Vector2.ZERO, 0.07)
	move_and_collide(velocity)

func _ready():
	$AnimatedSprite2D.play("idle")
	var health = 3

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
	
# ATTACK STUFF
func enemy():
	pass

func playerAttacked():
	pass


func _on_area_2d_2_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Resources.player_current_attack == true:
		health	= health - 1
		print ("enemy health = ", health)
		if health == 0:
			speed = 0
			player_chase = false
			player = null
			$AnimatedSprite2D.play("Death")
			$Timer.start()


func _on_timer_timeout():
	self.queue_free()
