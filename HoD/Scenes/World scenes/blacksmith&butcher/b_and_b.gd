extends Node2D
@onready var inventory = $CanvasLayer/Player/InventoryUI2
@onready var labello = get_node("%Balance")
var gold = 100

func _physics_process(delta: float) -> void:
	pass
	
func _ready():
	if (labello != null):
		labello.set_text("100")
	else:
		print("Label not found!")

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory.visible = !inventory.visible
