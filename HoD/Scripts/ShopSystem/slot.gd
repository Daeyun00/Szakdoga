extends PanelContainer
class_name Slot

@onready var manager = get_parent().get_parent()
@onready var player = Player.cost
@onready var texture_rect = $TextureRect


@export var item : Item = null:
	set(value):
		item = value
		
		if value != null:
			texture_rect.texture = value.texture
		else :
			texture_rect.texture = null

@export var a : int = 100

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
		elif destination == "Inventory" and source == "Shop" and manager.currency >= data.item.cost and not item:
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
	manager.currency += data.item.cost
	Global.remove_item(data.item.type, data.item.effect)
	a = manager.currency
	print(a)
	BAndB.gold = a
	print(BAndB.gold)

func buying(data):
	print("Bought" + data.item.name)
	manager.currency -= data.item.cost
	Global.add_item(data.item, false)
	a = manager.currency
	print(a)
	BAndB.gold = a
	print(BAndB.gold)
	
	
