extends Control

@export var menu : NinePatchRect
@export var party : NinePatchRect

@export var animation_player : AnimationPlayer

@export var description: NinePatchRect
@export var party_description : NinePatchRect
@onready var http_request = $Menu/VBoxContainer/Save/HTTPRequest
@onready var rich_text_lkabel = $RichTextLabel


enum STATE { MENU, RESUME, PARTY}
var ui_state = STATE.MENU

func _input(event):
	if event.is_action_pressed("ui_cancel") and not animation_player.is_playing():
		match ui_state:
			STATE.PARTY:
				ui_state = STATE.MENU
				hide_and_show("party", "menu")
			STATE.RESUME:
				if menu.visible == true:
					animation_player.play("hide_menu")
				else:
					animation_player.play("show_menu")
		

func set_party_description(character: Character):
	party_description.find_child("Icon").texture = character.texture
	party_description.find_child("Description").text = character.description
	
	
func hide_and_show(first: String, second: String):
	animation_player.play("hide_" + first)
	await animation_player.animation_finished
	animation_player.play("show_" + second)


func _on_party_pressed():
	ui_state = STATE.PARTY
	hide_and_show("menu", "party")


func _on_resume_pressed():
	ui_state = STATE.RESUME
	hide_and_show("menu", "resume")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

var url = "https://meowfacts.herokuapp.com/"



func _on_save_pressed():
	http_request.request(url)



func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	print(data.data[0])
	var cat_fact = data.data[0]
	rich_text_lkabel.text = cat_fact
