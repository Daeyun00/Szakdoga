extends Control

@export var menu : NinePatchRect
@export var party : NinePatchRect

@export var animation_player : AnimationPlayer

@export var description: NinePatchRect
@export var party_description : NinePatchRect

@export var player : Node2D


enum STATE { MENU, PARTY}
var ui_state = STATE.MENU

func _input(event):
	if Input.is_action_pressed("pause_menu") and not animation_player.is_playing():
		get_tree().paused = true
		
		
		
		
		match ui_state:
			STATE.PARTY:
				ui_state = STATE.MENU
				hide_and_show("party", "menu")
			STATE.MENU:
				if menu.visible == true:
					animation_player.play("hide_menu")
					get_tree().paused = false
					
					
					
					
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



	



func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")







func _ready() -> void:
	menu.hide()
