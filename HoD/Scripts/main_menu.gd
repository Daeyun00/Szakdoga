extends Control

@onready var menu = $Menu
@onready var Options = $Options
@onready var Video =  $Video
@onready var Audio = $Audio
@onready var resume_error: NinePatchRect = $resume_error
@onready var rich_text_label: RichTextLabel = $resume_error/RichTextLabel
@onready var ok: Button = $resume_error/ok


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume_error.hide()
	rich_text_label.hide()
	ok.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
	
func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/World scenes/VillageCenter/village_center.tscn")



func show_and_hide(first, second):
	first.show()
	second.hide()
	

func _on_exit_pressed() -> void:
	get_tree().quit()
	

func _on_video_pressed() -> void:
	show_and_hide(Video, Options)


func _on_audio_pressed() -> void:
	show_and_hide(Audio, Options)


func _on_back_from_options_pressed() -> void:
	show_and_hide(menu, Options)


func _on_resume_pressed() -> void:
	if FileAccess.file_exists("user://savegame.tres"):
		get_tree().change_scene_to_file("res://Scenes/World scenes/VillageCenter/village_center.tscn")
		var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	
	if not FileAccess.file_exists("user://savegame"):
		resume_error.show()
		rich_text_label.show()
		ok.show()
		menu.hide()
		
	
	


func _on_ok_pressed() -> void:
	resume_error.hide()
	rich_text_label.hide()
	ok.hide()
	menu.show()
