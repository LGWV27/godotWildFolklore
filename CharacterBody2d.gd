extends CharacterBody2D

@export var SPEED : int = 155
@export var GRAVITY : int = 900
@export var JUMP_FORCE : int = 255
var enemy = null
var contact = false
var attack_ip = false

# Time in seconds for how long the sprite should stay red
const DAMAGE_DURATION = 0.5
var damage_timer = 0.0
var is_damaged = false

func _physics_process(delta):
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and attack_ip == false:
			$AnimatedSprite2D.play("run")
		
	else:
		velocity.x = 0
		
		if is_on_floor() and attack_ip == false:
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
		
	attack()
	move_and_slide()

func _on_area_2d_2_body_entered(body):
	print("DEAD")

func _process(delta):	
	if Resources.player_health <= 0:
		pass
		# print("you died")
	if is_damaged:
		damage_timer -= delta
		if damage_timer <= 0:
			set_damaged(false)

func _on_area_2d_body_entered(body):
	enemy = body
	Resources.player_health -= 1
	apply_damage()
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
		apply_damage()
	else:
		pass

# ATTACK STUFF
func player():
	pass

func attack():
	if Input.is_action_just_pressed("Attack") and attack_ip == false:
		Resources.player_current_attack = true
		attack_ip = true
		$AnimatedSprite2D.play("attack")
		$attack_animation_cooldonw.start()
	else:
		Resources.player_current_attack = false


func _on_attack_animation_cooldonw_timeout():
	attack_ip = false
	
func apply_damage():
	set_damaged(true)
	damage_timer = DAMAGE_DURATION  # Reset the damage duration

func set_damaged(damaged):
	is_damaged = damaged
	var shader_material = $AnimatedSprite2D.material as ShaderMaterial
	shader_material.set("shader_param/damaged", damaged)
	if damaged:
		shader_material.set("shader_param/damage_color", Color(1.0, 0.0, 0.0, 1.0))  # Set damage color to red
