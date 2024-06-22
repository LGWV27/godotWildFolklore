extends CharacterBody2D

var speed = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	velocity.y = speed
	
	move_and_slide()


func _on_start_timer_timeout():
	speed = 0
