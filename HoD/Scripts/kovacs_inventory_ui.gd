extends Control

@onready var gridContainer = $GridContainer

func _ready():
	_on_inventory_updated()


func _on_inventory_updated():
	var slot = null
	var item1 = null
	var item2 = null
	for item in Global.kovacsInventory.size():
		slot = Global.kovacs_slot_scene.instantiate()
		gridContainer.add_child(slot)
	if slot != null:
		slot.set_item(Global.kovacsBuyItems[1])
	if slot == null:
		slot.set_empty()
