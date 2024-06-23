extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$StartTimer.start(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/ProgressBar.set_value(Resources.player_health)
