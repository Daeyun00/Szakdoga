extends GridContainer
class_name Inventory


@onready var slots = get_children()


func add_item(item : Item):
	for slot in slots:
		if slot.item == null:
			slot.item = item
			slots = slots
			return
	print("Can't add any more...")

func remove_item(item : Item):
	for slot in slots:
		if slot.item == item:
			slot.item = null
			slots = slots
			return
	print("Item not found...")
