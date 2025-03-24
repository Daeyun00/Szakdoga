extends Area2D
var is_player_within_area: bool
@onready var changing = $map_changing
@onready var label = $map_changing/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_within_area:
		changing.show()
		label.show()
	else :
		changing.hide()
		label.hide()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false
