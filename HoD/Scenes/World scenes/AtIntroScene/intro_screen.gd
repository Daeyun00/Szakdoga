extends Node2D

@export var animation_player: AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	Ui.menu.hide()
	Dialogic.start("intro")
	
	
