extends RichTextLabel

var _faded = false
var o = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	fade_in()
	if (_faded):
		set_text("until they face devastation...")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("Between the quiet walls of Demontide peace was the basis of everything.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("As the devil appeared, the joyful laughter vanished.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("The once known peace is now a fragile dream, a distant memory.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("Lands trembled, walls crumbled as he approached with his followers.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("Safius, the nightmare.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("The demon who follows the path of evil deeds.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("'Serve under me or you shall face my wrath' - he spoke to the trembling living.")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("Despite the hopeless situation and devastation...")
	await get_tree().create_timer(2.0).timeout
	fade_out()
	
	await get_tree().create_timer(2.0).timeout
	
	fade_in()
	if (_faded):
		set_text("There are those who haven't lost their spirits.")
	await get_tree().create_timer(2.0).timeout
	fade_out()

	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Outskirts_1.tscn")
	pass 


func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self , "modulate:a", 0, 2)
	tween.play()
	await tween.finished
	tween.kill()
	_faded = true

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 2)
	tween.play()
	await tween.finished
	tween.kill()
	_faded = false

func displayed_text(intro_text: String):
	fade_out()
	await get_tree().create_timer(2.0).timeout
	fade_in()
	if (_faded):
		set_text(intro_text)
	
