extends Node2D

@export var animation_player: AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	Ui.menu.hide()
	 



func _on_animation_player_animation_started(anim_name: StringName) -> void:
	Dialogic.start("intro")
