extends TextureRect

var goNow = false
var fading_in = true
var fading_out = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_modulate(Color(1, 1, 1, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not fading_in and not fading_out:
		return
	
	var modulate = get_modulate()
	if goNow == true:
		if fading_in:
			modulate.a = lerp(modulate.a, 1.0, 2 * delta)
			if modulate.a >= 0.99: # Almost fully opaque
				modulate.a = 1.0
				fading_in = false
				fading_out = true
		elif fading_out:
			modulate.a = lerp(modulate.a, 0.0, 2.5 * delta)
			if modulate.a <= 0.01: # Almost fully transparent
				modulate.a = 0.0
				fading_out = false
				await get_tree().create_timer(0.5).timeout
				get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	set_modulate(modulate)


func _on_godot_pride_fade_out_completed():
	goNow = true
