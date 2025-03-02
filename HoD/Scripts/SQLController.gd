extends Control

var database : SQLite

func _ready():
	database = SQLite.new()
	database.path = "res://database.db"
	database.open_db()





func _on_create_table_button_down() -> void:
	var alliesTable = {
		"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name":{"data_type":"text"},
		"lvl":{"data_type":"int"},
		"exp":{"data_type":"int"},
		"gold":{"data_type":"int"},
		"atk":{"data_type":"int"},
		"max_att":{"data_type":"int"},
		"def":{"data_type":"int"},
		"max_def":{"data_type":"int"},
		"hp":{"data_type":"int"},
		"max_hp":{"data_type":"int"},
		"resource":{"data_type":"int"},
		"max_resource":{"data_type":"int"},
		"resource_name":{"data_type":"int"}
		
		
	}
	var hostilesTable = {
		"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name":{"data_type":"text"},
		"atk":{"data_type":"int"},
		"max_att":{"data_type":"int"},
		"def":{"data_type":"int"},
		"max_def":{"data_type":"int"},
		"hp":{"data_type":"int"},
		"max_hp":{"data_type":"int"},
		"loot_gold":{"data_type":"int"},
		"loot_exp":{"data_type":"int"},
		"loot_items":{"data_type":"int"}
	}
	var itemTable = {
		"id": {"data_type":"int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name":{"data_type":"text"}
	}
	var shopInventoryTable = {
		"Item_id":{"data_type": "int"},
		"cost":{"data_type": "int"},
		"bought":{"data_type":"bool"}
	}
	var inventoryTable = {
		"id":{"data_type": "int", "auto_increment": true},
		"item_id":{"data_type": "int"}
	}
	var mapBattlesTable = {
		"id":{"data_type": "int", "auto_increment": true},
		"enemy": {"data_type": "int"},
		"quantity": {"data_type":"int"}
	}
	database.create_table("allies", alliesTable)
	database.create_table("hostiles", hostilesTable)
	database.create_table("items", itemTable)
	database.create_table("shopInventory", shopInventoryTable)
	database.create_table("inventory", inventoryTable)
	database.create_table("map_battle", mapBattlesTable)
	
