extends CharacterBody2D

@export var SPEED : int = 155
@export var GRAVITY : int = 900
@export var JUMP_FORCE : int = 500
@export var DOUBLE_JUMP_FORCE : int = 400
var jump_cooldown = false
var doubleJumpCounter = 0
var enemy = null
var contact = false
var attack_ip = false
var currently_falling = false

var immune = false
var landCooldown = false

var dying = false

const attack_sound = preload("res://Assets/Sound/attack.mp3")
const jump_sound = preload("res://Assets/Sound/389634__stubb__wing-flap-1.wav")
const player_pain = preload("res://Assets/Sound/PPAIN.mp3")
const player_dead = preload("res://Assets/Sound/deathP.mp3")

# Time in seconds for how long the sprite should stay red
const DAMAGE_DURATION = 0.3
var damage_timer = 0.0
var is_damaged = false

var screen_min_x = -4
var screen_max_x = 358

func _physics_process(delta):
	var direction = Input.get_axis("moveLeft", "moveRight")
	
	position.x = wrapf(position.x, screen_min_x, screen_max_x)
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor() and attack_ip == false:
			$AnimatedSprite2D.play("run")
		
	else:
		velocity.x = 0
		
		if is_on_floor() and attack_ip == false and landCooldown == false and dying == false:
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
		AudioPlayer.play_FX(jump_sound, -12)
		jump_cooldown = true
		$jumpcooldown.start(0.2)
	if Input.is_action_just_pressed("Jump") and not is_on_floor() and jump_cooldown == false:
		doubleJumpCounter += 1
		if doubleJumpCounter <= 1:
			velocity.y -= DOUBLE_JUMP_FORCE
			$AnimatedSprite2D.play("jump")
			AudioPlayer.play_FX(jump_sound, -15)
		else:
			pass
	if is_on_floor():
		doubleJumpCounter = 0
		if currently_falling == true:
			landCooldown = true
			$AnimatedSprite2D.play("land")
			$landcooldown.start(0.25)
			currently_falling = false
	
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
			currently_falling = true
		
	attack()
	move_and_slide()

func _process(delta):	
	if is_damaged:
		damage_timer -= delta
		if damage_timer <= 0:
			set_damaged(false)

func _on_area_2d_body_entered(body):
	enemy = body
	if immune == false:
		Resources.player_health -= 1
		Resources.noDamage = false
		immune = true
		$immunity.start(1)
		AudioPlayer.play_FX(player_pain, -12)
	apply_damage()
	contact = true
	$Timer.start(2)
	print("timer start")


func _on_area_2d_body_exited(body):
	contact = false


func _on_timer_timeout():
	print("timer")
	if contact == true:
		if immune == false:
			Resources.player_health -= 1
			Resources.noDamage = false
			immune = true
			$immunity.start(1)
			AudioPlayer.play_FX(player_pain, -12)
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
		AudioPlayer.play_FX(attack_sound, -12)
		$attack_animation_cooldonw.start(0.40)
	else:
		Resources.player_current_attack = false


func _on_attack_animation_cooldonw_timeout():
	attack_ip = false
	
func apply_damage():
	if Resources.player_health <= 0:
		dying = true
		SPEED = 0
		JUMP_FORCE = 0
		DOUBLE_JUMP_FORCE = 0
		$AnimatedSprite2D.play("dead")
		AudioPlayer.play_FX(player_dead, -12)
		$death.start(0.5)
	set_damaged(true)
	damage_timer = DAMAGE_DURATION  # Reset the damage duration

func set_damaged(damaged):
	is_damaged = damaged
	var shader_material = $AnimatedSprite2D.material as ShaderMaterial
	shader_material.set("shader_param/damaged", damaged)
	if damaged:
		shader_material.set("shader_param/damage_color", Color(1.0, 0.0, 0.0, 1.0))  # Set damage color to red


func _on_jumpcooldown_timeout():
	jump_cooldown = false


func _on_landcooldown_timeout():
	landCooldown = false


func _on_death_timeout():
	get_tree().change_scene_to_file("res://Scenes/end_game.tscn")


func _on_immunity_timeout():
	immune = false


func _on_bigdeathbad_body_entered(body):
	if body.has_method("player"):
		Resources.player_health = 0
		Resources.noDamage = false
		AudioPlayer.play_FX(player_pain, -12)
		apply_damage()
	else:
		pass
