extends Area2D
var is_player_within_area: bool
var first_interaction: bool
@onready var ninep = $"../NinePatchRect"
@onready var hbox = $"../HBoxContainer"
@onready var label = $"../RichTextLabel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_within_area:
		
		label.show()
		hbox.show()
		ninep.show()
	else :
		hbox.hide()
		label.hide()
		ninep.hide()



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true
		
		


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == false:
		Dialogic.start("object_saver")
		first_interaction = true
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == true:
		Dialogic.start("object_saver_1")
		
