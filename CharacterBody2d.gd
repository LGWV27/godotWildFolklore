extends CharacterBody2D

@export var SPEED : int = 155
@export var GRAVITY : int = 900
@export var JUMP_FORCE : int = 255
var enemy = null
var contact = false


func _physics_process(delta):
	
	
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction:
		velocity.x = direction * SPEED
		
		if is_on_floor():
			$AnimatedSprite2D.play("run")
		
	else:
		velocity.x = 0
		
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
	
	#Rotate
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
	elif direction == 1:
		$AnimatedSprite2D.flip_h = true
	
	#Jump
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y -= JUMP_FORCE
		
		$AnimatedSprite2D.play("jump")
	
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
		
	move_and_slide()

func _on_area_2d_2_body_entered(body):
	print("DEAD")

func _process(delta):	
	if Resources.player_health <= 0:
		print("you died")

func _on_area_2d_body_entered(body):
	enemy = body
	Resources.player_health -= 1
	contact = true
	$Timer.start(2)
	print("timer start")


func _on_area_2d_body_exited(body):
	contact = false


func _on_timer_timeout():
	print("timer")
	if contact == true:
		Resources.player_health -= 1
		print("timer health drain")
	else:
		pass
