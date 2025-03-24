extends Node2D
var teleport_ready = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	teleport_ready = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	teleport_ready = false

func _process(delta: float) -> void:
	if(teleport_ready):
		if(Input.is_action_pressed("ui_up")):
			teleport_ready = false
			$CanvasLayer/Player.visible = false
			get_tree().change_scene_to_file("res://Scenes/World scenes/blacksmith&butcher/blacksmith_and_butcher.tscn")
