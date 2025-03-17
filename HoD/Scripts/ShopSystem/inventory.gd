extends GridContainer
class_name Inventory


@onready var slots = get_children()

func _ready():
	add_item(load("res://Scenes/ShopSystem/dagger.tres"))

func add_item(item : Item):
	for slot in slots:
		if slot.item == null:
			slot.item = item
			return
	print("Can't add any more...")

func remove_item(item : Item):
	for slot in slots:
		if slot.item == item:
			slot.item = null
			return
	print("Item not found...")
