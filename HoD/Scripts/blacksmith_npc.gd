extends CharacterBody2D


@onready var ui = $UI

var player_in_range = false


func interact():
	pass

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		body.shopInterac_ui.visible = true



func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		body.shopInterac_ui.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("Buy"):
		ui.visible = !ui.visible
