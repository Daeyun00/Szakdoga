extends Area2D


var is_player_within_area: bool
var first_interaction : bool

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == false:
		Dialogic.start("bartedner")
		first_interaction = true
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == true:
		Dialogic.start("bartender1")
