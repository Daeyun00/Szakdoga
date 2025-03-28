extends PanelContainer
class_name Slot

@onready var manager = get_parent().get_parent()
@onready var texture_rect = $TextureRect
@onready var info = $Manager/ColorRect


@export var item : Item = null:
	set(value):
		item = value
		
		if value != null:
			texture_rect.texture = value.texture
		else :
			texture_rect.texture = null

@export var a : int = 100

func _ready():
	SqlController.database.delete_rows("inventory", "item_id")
	SqlController.database.delete_rows("shopInventory", "item_id")
	

func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.custom_minimum_size = Vector2(20, 20)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	preview_texture.position = -0.5 * Vector2(20, 20)
	
	return preview

func _can_drop_data(_pos, data):
	var source = data.get_parent().name
	var destination = get_parent().name
	if data is Slot:
		if destination == "Shop" and source == "Inventory" and not item:
			return true
		elif destination == "Inventory" and source == "Shop" and Global.currency >= data.item.cost and not item:
			return true
		elif destination == source:
			return true
	return false

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return self

func _drop_data(at_position, data):
	var source = data.get_parent().name
	var destination = get_parent().name
	
	if destination == "Shop" and source == "Inventory":
		selling(data)
	elif destination == "Inventory" and source == "Shop":
		buying(data)
	var temp = item
	item = data.item
	data.item = temp

func selling(data):
	print("Sold" + data.item.name)
	Global.currency += data.item.cost
	Global.remove_item(data.item.type, data.item.effect)
	if data.item.name == "Health_potion":
		SqlController.database.delete_rows("inventory", "item_id = " + str(1))
	if data.item.name == "Mana potion":
		SqlController.database.delete_rows("inventory", "item_id = " + str(2))
	if data.item.name == "Riptide_dagger":
		SqlController.database.delete_rows("inventory", "item_id = " + str(3))
	if data.item.name == "Runic_dagger":
		SqlController.database.delete_rows("inventory", "item_id = " + str(4))
	if data.item.name == "Stamina dagger":
		SqlController.database.delete_rows("inventory", "item_id = " + str(5))

func buying(data):
	print("Bought" + data.item.name)
	Global.currency -= data.item.cost
	Global.add_item(data.item, false)
	if data.item.name == "Health_potion":
		var elem = {
			"item_id": 1
		}
		SqlController.database.insert_row("inventory", elem)
		SqlController.database.update_rows("shopInventory", "item_id = " + str(1), {"bought": true})
	if data.item.name == "Mana potion":
		var elem = {
			"item_id": 2
		}
		SqlController.database.insert_row("inventory", elem)
		SqlController.database.update_rows("shopInventory", "item_id = " + str(2), {"bought": true})
	if data.item.name == "Riptide_dagger":
		var elem = {
			"item_id": 3
		}
		SqlController.database.insert_row("inventory", elem)
		SqlController.database.update_rows("shopInventory", "item_id = " + str(3), {"bought": true})
	if data.item.name == "Runic_dagger":
		var elem = {
			"item_id": 4
		}
		SqlController.database.insert_row("inventory", elem)
		SqlController.database.update_rows("shopInventory", "item_id = " + str(4), {"bought": true})
		
	if data.item.name == "Stamina potion":
		var elem = {
			"item_id": 5
		}
		SqlController.database.insert_row("inventory", elem)
		SqlController.database.update_rows("shopInventory", "item_id = " + str(5), {"bought": true})
