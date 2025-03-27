extends Node2D

var animation_played = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	
	Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
	
	 



func _on_animation_player_animation_started(anim_name: StringName) -> void:
	Dialogic.start("intro")


func _process(delta):
	if $AnimationPlayer.is_playing() == false and !animation_played:	
		animation_played = true
	
