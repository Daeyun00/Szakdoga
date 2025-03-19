extends Node
class_name SaverLoader

@onready var player = $CanvasLayer/Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_save_pressed() -> void:
	var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	file.store_var(player.global_position)
	file.close()


func _on_load_pressed() -> void:
	var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	player.global_position = file.get_var()
	print("loaded.")
	file.close()
