extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Player/Camera2D/RichTextLabel.text = str(Resources.player_health)
