extends Node2D
@onready var inventory = $CanvasLayer/Player/InventoryUI2

var gold = 100

func _ready():
	%Balance.text = "100"

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory.visible = !inventory.visible
