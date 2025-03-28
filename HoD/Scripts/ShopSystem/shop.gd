extends Inventory

#region Test
@export var items : Array[Item]

func _ready():
	load_items(items)
	SqlController.database.insert_row("shopInventory", {"item_id": 1, "cost": 40, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 2, "cost": 50, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 3, "cost": 35, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 4, "cost": 40, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 5, "cost": 50, "bought": false})
#endregion

func load_items(items):
	reset()
	for item in items:
		add_item(item)

func reset():
	for slot in get_children():
		slot.item = null
