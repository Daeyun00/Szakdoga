extends Button

var MaxHP = 100
var HP = 100
var MaxRage = 100
var Rage = 100
var MaxATK = 0
var ATK = 0
var MaxDEF = 0
var DEF = 0

@onready var interact_ui = $InteractUI
@onready var inventory_ui = $InventoryUI
@onready var inventory_hotbar = $Inventory_Hotbar



func _input(event):
	if event.is_action_pressed("ui_inventory"):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused
		inventory_hotbar.visible = !inventory_hotbar.visible


func apply_item_effect(item):
	match item["effect"]:
		"Health":
			HP += 5
			print("HP increased to ", HP)
		"Stanima":
			Rage += 10
			print("Rage incrase to ", Rage)
		"Armor":
			DEF += 10
			print("DEF incrase to ", DEF)
		_:
			print("There is no effect for this item")
