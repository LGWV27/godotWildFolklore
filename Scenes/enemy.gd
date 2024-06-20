extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

func _physics_process(delta):
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

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
