extends Node


# Called when the node enters the scene tree for the first time.
var inventory = []

signal inventory_updated

var player_node = null



func _ready():
	inventory.resize(30)

func  add_item():
	inventory_updated.emit()
func remove_item():
	inventory_updated.emit()
func incrase_inventory_size():
	inventory_updated.emit()
func set_player_reference(player):
	player_node = player
