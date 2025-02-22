extends Area2D


var player_in_area = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func ended_dialogue():
	Dialogic.timeline_ended.disconnect(ended_dialogue)

func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
			player_in_area = true
			
	if Input.is_action_just_pressed("interact"):
		Dialogic.start_timeline("blacksmith")
		


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("Player"):
		player_in_area = false
	
