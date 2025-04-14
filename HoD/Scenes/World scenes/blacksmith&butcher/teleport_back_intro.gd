extends Area2D
var teleport_ready = false

func _process(delta: float) -> void:
	if(teleport_ready and Input.is_action_pressed("ui_up")):
		get_tree().change_scene_to_file("res://Scenes/World scenes/AtIntroScene/atintroscene_.tscn")
