extends Control

var database : SQLite

@onready var insertDataAllies = $InsertdataAllies
@onready var insertDataHostiles = $InsertdataHostiles
@onready var insertDataItem = $InsertdataItem
@onready var insertDataShopInventory = $InsertdataShopInventory
@onready var insertDataInventory = $InsertdataInventory
@onready var insertDataMapBattle = $InsertdataMapBattle

@onready var selectDataAllies = $SelectdataAllies
@onready var selectDataHostiles = $SelectdataHostiles
@onready var selectDataItem = $SelectdataItem
@onready var selectDataShopInventory = $SelectdataShopInventory
@onready var selectDataInventory = $SelectdataInventory
@onready var selectDataMapBattle = $SelectdataMapBattle

@onready var updateDataAllies = $UpdatedataAllies
@onready var updateDataHostiles = $UpdatedataHostiles
@onready var updateDataItem = $UpdatedataItem
@onready var updateDataShopInventory = $UpdatedataShopInventory
@onready var updateDataInventory = $UpdatedataInventory
@onready var updateDataMapBattle = $UpdatedataMapBattle

@onready var deleteDataAllies = $DeletedataAllies
@onready var deleteDataHostiles = $DeletedataHostiles
@onready var deleteDataItem = $DeletedataItem
@onready var deleteDataShopInventory = $DeletedataShopInventory
@onready var deleteDataInventory = $DeletedataInventory
@onready var deleteDataMapBattle = $DeletedataMapBattle

@onready var customSelectAllies = $CustomSelectAllies
@onready var customSelectHostiles = $CustomSelectHostiles
@onready var customSelectItem = $CustomSelectItem
@onready var customSelectShopInventory = $CustomSelectShopInventory
@onready var customSelectInventory = $CustomSelectInventory
@onready var customSelectMapBattle = $CustomSelectMapBattle

@onready var storAlliesImage = $StoreAlliesImage
@onready var storHostilesImage = $StoreHostilesImage
@onready var storItemImage = $StoreItemImage
@onready var storShopInventoryImage = $StoreShopInventoryImage
@onready var storInventoryImage = $StoreInventoryImage
@onready var storMapBattleImage = $StoreMapBattleImage

@onready var alliesNameLabel = $LabelName
@onready var alliesName = $Name
@onready var alliesLvlLabel = $Labellvl
@onready var alliesLvl = $lvl
@onready var alliesExpLabel = $Labelexp
@onready var alliasExp = $exp
@onready var alliasGoldLabel = $Labelgold
@onready var alliasGold = $gold
@onready var alliasAtkLabel = $Labelatk
@onready var alliasAtk = $atk
@onready var alliasMaxattLabel = $Labelmaxatt
@onready var alliasMaxAtt = $maxAtt
@onready var alliasDefLabel = $Labeldef
@onready var alliasDef = $def
@onready var alliasMaxDefLabel = $LabelmaxDef
@onready var alliasMaxDef = $maxdef
@onready var alliasHpLabel = $Labelhp
@onready var alliasHp = $hp
@onready var alliasMaxHpLabel = $LabelmaxHP
@onready var alliasMaxHp = $maxHP
@onready var alliasResourceLabel = $Labelresource
@onready var alliasResource = $resource
@onready var alliasMaxResourceLabel = $LabelmaxResource
@onready var alliasMaxResource = $maxResource
@onready var alliasResourceNameLabel = $LabelResourceName
@onready var alliasResourceName = $resourceName

@onready var hostilesNameLabel = $LabelatkName2
@onready var hostilesName = $name2
@onready var hostilesAtkLabel = $Labelatk2
@onready var hostilesAtk = $atk2
@onready var hostilesMaxAttLabel = $LabelmaxAtt2
@onready var hostilesMaxAtt = $maxAtt2
@onready var hostilesDefLabel = $LabelDef2
@onready var hostilesDef = $def2
@onready var hostilesMaxDefLabel = $LabelMaxDef2
@onready var hostilesMaxDef = $maxDef2
@onready var hostilesHpLabel = $LabelHP2
@onready var hostilesHp = $HP2
@onready var hostilesMaxHpLabel = $LabelmaxHp2
@onready var hostilesMaxHp = $maxHp2
@onready var hostilesLootGoldLabel = $LabelLootGold
@onready var hostileslootGold = $lootGold
@onready var hostilesLootExpLabel = $LabelLootExp
@onready var hostilesLootExp = $lootExp

@onready var itemNameLabel = $LabelItemName
@onready var itemName = $itemName

@onready var shopInventoryCostLabel = $LabelCost
@onready var shopInventoryCost = $cost

@onready var mapBattleQuantityLabel = $LabelQuantity
@onready var mapBattleQuantity = $quantity

@onready var effect = $effect
@onready var effectLabel = $effectLabel



func _ready():
	database = SQLite.new()
	database.path = "res://databaseUltimate.db"
	database.open_db()
	SqlController.database.insert_row("shopInventory", {"item_id": 1, "cost": 40, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 2, "cost": 50, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 3, "cost": 35, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 4, "cost": 40, "bought": false})
	SqlController.database.insert_row("shopInventory", {"item_id": 5, "cost": 50, "bought": false})





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
		"name":{"data_type":"text"},
		"effect":{"data_type": "text"}
	}
	var shopInventoryTable = {
		"Item_id":{"data_type": "int"},
		"cost":{"data_type": "int"},
		"bought":{"data_type":"bool"}
	}
	var inventoryTable = {
		"id":{"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
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
	


func _on_allies_button_pressed() -> void:
	insertDataAllies.visible = !insertDataAllies.visible
	selectDataAllies.visible = !selectDataAllies.visible
	updateDataAllies.visible = !updateDataAllies.visible
	customSelectAllies.visible = !customSelectAllies.visible
	deleteDataAllies.visible = !deleteDataAllies.visible
	storAlliesImage.visible = !storAlliesImage.visible
	alliesNameLabel.visible = !alliesNameLabel.visible
	alliesName.visible = !alliesName.visible
	alliesLvlLabel.visible = !alliesLvlLabel.visible
	alliesLvl.visible = !alliesLvl.visible
	alliesExpLabel.visible = !alliesExpLabel.visible
	alliasExp.visible = !alliasExp.visible
	alliasGoldLabel.visible = !alliasGoldLabel.visible
	alliasGold.visible = !alliasGold.visible
	alliasAtkLabel.visible = !alliasAtkLabel.visible
	alliasAtk.visible = !alliasAtk.visible
	alliasMaxAtt.visible = !alliasMaxAtt.visible
	alliasMaxattLabel.visible = !alliasMaxattLabel.visible
	alliasDefLabel.visible = !alliasDefLabel.visible
	alliasDef.visible = !alliasDef.visible
	alliasMaxDefLabel.visible = !alliasMaxDefLabel.visible
	alliasMaxDef.visible = !alliasMaxDef.visible
	alliasHpLabel.visible = !alliasHpLabel.visible
	alliasHp.visible = !alliasHp.visible
	alliasMaxHpLabel.visible = !alliasMaxHpLabel.visible
	alliasMaxHp.visible = !alliasMaxHp.visible
	alliasResourceLabel.visible = !alliasResourceLabel.visible
	alliasResource.visible = !alliasResource.visible
	alliasMaxResourceLabel.visible = !alliasMaxResourceLabel.visible
	alliasMaxResource.visible = !alliasMaxResource.visible
	alliasResourceNameLabel.visible = !alliasResourceNameLabel.visible
	alliasResourceName.visible = ! alliasResourceName.visible


func _on_hostiles_button_pressed() -> void:
	insertDataHostiles.visible = !insertDataHostiles.visible
	selectDataHostiles.visible = !selectDataHostiles.visible
	customSelectHostiles.visible = !customSelectHostiles.visible
	updateDataHostiles.visible = !updateDataHostiles.visible
	deleteDataHostiles.visible = !deleteDataHostiles.visible
	storHostilesImage.visible = !storHostilesImage.visible
	hostilesNameLabel.visible = !hostilesNameLabel.visible
	hostilesName.visible = !hostilesName.visible
	hostilesAtkLabel.visible = !hostilesAtkLabel.visible
	hostilesAtk.visible = !hostilesAtk.visible
	hostilesMaxAttLabel.visible = !hostilesMaxAttLabel.visible
	hostilesMaxAtt.visible = !hostilesMaxAtt.visible
	hostilesDefLabel.visible = !hostilesDefLabel.visible
	hostilesDef.visible = !hostilesDef.visible
	hostilesMaxDefLabel.visible = !hostilesMaxDefLabel.visible
	hostilesMaxDef.visible = !hostilesMaxDef.visible
	hostilesHpLabel.visible = !hostilesHpLabel.visible
	hostilesHp.visible = !hostilesHp.visible
	hostilesMaxHpLabel.visible = !hostilesMaxHpLabel.visible
	hostilesMaxHp.visible = !hostilesMaxHp.visible
	hostilesLootGoldLabel.visible = !hostilesLootGoldLabel.visible
	hostileslootGold.visible = !hostileslootGold.visible
	hostilesLootExpLabel.visible = !hostilesLootExpLabel.visible
	hostilesLootExp.visible = !hostilesLootExp.visible




func _on_item_button_pressed() -> void:
	insertDataItem.visible = !insertDataItem.visible
	selectDataItem.visible = !selectDataItem.visible
	customSelectItem.visible = !customSelectItem.visible
	updateDataItem.visible = !updateDataItem.visible
	deleteDataItem.visible = !deleteDataItem.visible
	itemNameLabel.visible = !itemNameLabel.visible
	itemName.visible = !itemName.visible
	storItemImage.visible = !storItemImage.visible
	effect.visible = !effect.visible
	effectLabel.visible = !effectLabel.visible
	



func _on_shop_inventory_button_pressed() -> void:
	insertDataShopInventory.visible = !insertDataShopInventory.visible
	selectDataShopInventory.visible = !selectDataShopInventory.visible
	customSelectShopInventory.visible = !customSelectShopInventory.visible
	updateDataShopInventory.visible = !updateDataShopInventory.visible
	deleteDataShopInventory.visible = !deleteDataShopInventory.visible
	shopInventoryCostLabel.visible = !shopInventoryCostLabel.visible
	shopInventoryCost.visible = !shopInventoryCost.visible
	storShopInventoryImage.visible = !storShopInventoryImage.visible



func _on_inventory_button_pressed() -> void:
	insertDataInventory.visible = !insertDataInventory.visible
	selectDataInventory.visible = !selectDataInventory.visible
	customSelectInventory.visible = !customSelectInventory.visible
	updateDataInventory.visible = !updateDataInventory.visible
	deleteDataInventory.visible = !updateDataInventory.visible
	storInventoryImage.visible = !storInventoryImage.visible




func _on_map_battle_button_pressed() -> void:
	insertDataMapBattle.visible = !insertDataMapBattle.visible
	selectDataMapBattle.visible = !selectDataMapBattle.visible
	customSelectMapBattle.visible = !customSelectMapBattle.visible
	updateDataMapBattle.visible = !updateDataMapBattle.visible
	deleteDataMapBattle.visible = !deleteDataMapBattle.visible
	storMapBattleImage.visible = !storMapBattleImage.visible
	mapBattleQuantityLabel.visible = !mapBattleQuantityLabel.visible
	mapBattleQuantity.visible = !mapBattleQuantity.visible


func _on_insertdata_allies_button_down() -> void:
	var data = {
		"name": alliesName.text,
		"lvl": int(alliesLvl.text),
		"exp": int(alliasExp.text),
		"gold": int(alliasGold.text),
		"atk": int(alliasAtk.text),
		"max_att": int(alliasMaxAtt.text),
		"def": int(alliasDef.text),
		"max_def": int(alliasMaxDef.text),
		"hp": int(alliasHp.text),
		"max_hp": int(alliasMaxHp.text),
		"resource": int(alliasResource.text),
		"max_resource": int(alliasMaxResource.text),
		"resource_name": int(alliasResourceName.text)
	}
	database.insert_row("allies", data)


func _on_selectdata_allies_button_down() -> void:
	print(database.select_rows("allies", "lvl > 10", ["*"]))


func _on_updatedata_allies_button_down() -> void:
	database.update_rows("allies", "name = '" + alliesName.text + "'", {"lvl": int(alliesLvl.text), "exp": int(alliasExp.text), "gold": int(alliasGold.text), "atk": int(alliasAtk.text), "def": int(alliasDef.text), "hp": int(alliasHp.text), "resource": int(alliasResource.text), "resource_name": int(alliasResourceName.text)})


func _on_deletedata_allies_button_down() -> void:
	database.delete_rows("allies", "name = '" + alliesName.text + "'")


func _on_insertdata_hostiles_button_down() -> void:
	var data = {
		"name": hostilesName.text,
		"atk":int(hostilesAtk.text),
		"max_att": int(hostilesMaxAtt.text),
		"def": int(hostilesDef.text),
		"max_def": int(hostilesMaxDef.text),
		"hp": int(hostilesHp.text),
		"max_hp": int(hostilesMaxHp.text),
		"loot_gold": int(hostileslootGold.text),
		"loot_exp": int(hostilesLootExp.text)
	}
	database.insert_row("hostiles", data)



func _on_insertdata_item_button_down() -> void:
	var data = {
		"name": itemName.text,
		"effect": effect.text
	}
	database.insert_row("items", data)


func _on_insertdata_shop_inventory_button_down() -> void:
	var data = {
		"cost": int(shopInventoryCost.text)
	}
	database.insert_row("shopInventory", data)


func _on_insertdata_map_battle_button_down() -> void:
	var data = {
		"quantity": int(mapBattleQuantity.text)
	}
	database.insert_row("map_battle", data)


func _on_selectdata_hostiles_button_down() -> void:
	print(database.select_rows("hostiles", "loot_gold > 0", ["*"]))




func _on_selectdata_shop_inventory_button_down() -> void:
	print(database.select_rows("shopInventory", "cost > 1", ["*"]))



func _on_selectdata_map_battle_button_down() -> void:
	print(database.select_rows("map_battle", "quantity > 0", ["*"]))


func _on_updatedata_hostiles_button_down() -> void:
	database.update_rows("hostiles", "name = '" + hostilesName.text + "'", {"atk": int(hostilesAtk.text), "def": int(hostilesDef.text), "hp": int(hostilesHp.text), "loot_gold": int(hostileslootGold.text), "loot_exp": int(hostilesLootExp.text)})


func _on_deletedata_hostiles_button_down() -> void:
	database.delete_rows("hostiles", "name = '" + hostilesName.text + "'")




func _on_deletedata_item_button_down() -> void:
	database.delete_rows("items", "name = '" + itemName.text + "'")
	print("Siker")
