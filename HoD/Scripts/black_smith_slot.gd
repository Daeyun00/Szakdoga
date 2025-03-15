extends Control

@onready var detailsPanel = $DetailsPanel
@onready var usagePanel = $UsagePanel
@onready var icon = $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffecct
@onready var outerBorder = $OuterBorder

var item = null

signal drag_start(slot)
signal drag_end()
signal inventory_updated

func _on_item_button_mouse_entered() -> void:
	detailsPanel.visible = true


func _on_item_button_mouse_exited() -> void:
	detailsPanel.visible = false


func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("+ ", item["effect"])
	else:
		item_effect.text = ""

func _on_item_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			if item != null:
				usagePanel.visible = !usagePanel.visible
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				outerBorder.modulate = Color(1, 1, 0)
				drag_start.emit(self)
			else:
				outerBorder.modulate = Color(1, 1, 1)
				drag_end.emit()



func _on_use_button_gui_input(event):
	var currency = 100
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			icon.texture = null
			item_name.text = "Name"
			item_type.text = "Type"
			item_effect.text = "Effect"
		for i in range(Global.inventory.size()):
					# Check if the item exists in the inventory and matches both type and effect
			if Global.inventory[i] != null and Global.inventory[i]["type"] == item["type"] and Global.inventory[i]["effect"] == item["effect"]:
				Global.inventory_updated.emit()
				print("Item added", Global.inventory)
				return true
			elif Global.inventory[i] == null:
				Global.inventory[i] = item
				inventory_updated.emit()
				print("Item added", Global.inventory)
				return true
		return false
