extends Area2D
var is_player_within_area: bool
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var rich_text_label: RichTextLabel = $RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_player_within_area:
		nine_patch_rect.show()
		h_box_container.show()
		rich_text_label.show()
	else:
		nine_patch_rect.hide()
		h_box_container.hide()
		rich_text_label.hide()


func _on_body_entered(body: Node2D) -> void:
		if body.name == "Player":
			is_player_within_area = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false
