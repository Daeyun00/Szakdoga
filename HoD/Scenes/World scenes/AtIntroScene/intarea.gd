extends Area2D

var player_is_in_area = false
# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	if player_is_in_area:
		get_tree().paused
		if Input.is_action_pressed("interact"):
			run_dialogue("1")




func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("Player"):
		player_is_in_area = true


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.has_method("Player"):
			player_is_in_area = false
