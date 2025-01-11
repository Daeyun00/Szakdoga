extends Node


var inventory = []

signal inventory_updated

var player_node: Node = null


<<<<<<< Updated upstream

func _ready():
	inventory.resize(30)

func add_item():
	inventory_updated.emit()

func remove_item():
	inventory_updated.emit()

func increase_inventory_size():
	inventory_updated.emit()
	
=======
func _ready():
	inventory.resize(30)
func add_item():
	inventory_updated.emit()
func remove_item():
	inventory_updated.emit()
func increase_inventory_size():
	inventory_updated.emit()

>>>>>>> Stashed changes
func set_player_reference(player):
	player_node = player
