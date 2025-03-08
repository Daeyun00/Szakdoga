extends CharacterBody2D

var player_in_range = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		body.shopInterac_ui.visible = true



func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		body.shopInterac_ui.visible = false
