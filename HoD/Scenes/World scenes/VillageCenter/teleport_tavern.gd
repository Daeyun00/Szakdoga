extends Area2D

var teleport_ready = false


func _process(delta: float) -> void:
	if(teleport_ready && Input.is_action_pressed("ui_up")):
		get_tree().change_scene_to_file("res://Scenes/World scenes/blacksmith&butcher/tavern/tavern.tscn")

func _on_area_entered(area: Area2D) -> void:
	teleport_ready = true


func _on_area_exited(area: Area2D) -> void:
	teleport_ready = false
