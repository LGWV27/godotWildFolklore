extends CharacterBody2D

var speed = 25
var player_chase = false
var player = null

var health = 1
var player_inattack_zone = false

var not_giggled = true

# Time in seconds for how long the sprite should stay red
const DAMAGE_DURATION = 0.3
var damage_timer = 0.0
var is_damaged = false

@onready var animated_sprite = $AnimatedSprite2D

const boss_dead = preload("res://Assets/Sound/13797__sweetneo85__wilhelm.wav")
const boss_giggle = preload("res://Assets/Sound/hehehe.mp3")

func _process(delta):
	if is_damaged:
		damage_timer -= delta
		if damage_timer <= 0:
			set_damaged(false)

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
	var health = 1
	var original_material = animated_sprite.material
	var new_material = original_material.duplicate()
	animated_sprite.material = new_material
	
# ATTACK STUFF
func enemy():
	pass

func playerAttacked():
	pass


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Resources.player_current_attack == true:
		health	= health - 1
		apply_damage()
		print ("enemy health = ", health)
		if health == 0:
			speed = 0
			player_chase = false
			player = null
			$Timer.start(1)
			AudioPlayer.play_FX(boss_dead, -12)
			Resources.endSuccess = true

func apply_damage():
	set_damaged(true)
	damage_timer = DAMAGE_DURATION  # Reset the damage duration

func set_damaged(damaged):
	is_damaged = damaged
	var shader_material = $AnimatedSprite2D.material as ShaderMaterial
	shader_material.set("shader_param/damaged", damaged)
	if damaged:
		shader_material.set("shader_param/damage_color", Color(1.0, 0.0, 0.0, 1.0))  # Set damage color to red

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/end_game.tscn")
	self.queue_free()


func _on_area_2d_2_body_entered(body):
	if body.has_method("player") and not_giggled == true:
		AudioPlayer.play_FX(boss_giggle, -15)
		not_giggled = false
	else:
		pass
