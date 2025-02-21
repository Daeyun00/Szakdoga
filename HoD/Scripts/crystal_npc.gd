extends Node2D


var player_is_in_area = false

func _process(delta: float) -> void:
	if player_is_in_area:
		if Input.is_action_pressed("interact"):
			run_dialogue("1")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		player_is_in_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_is_in_area = false


func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	Dialogic.start("1")
