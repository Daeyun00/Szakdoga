@tool
extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_texture: Texture
@export var item_effect = ""
@export var item_cost = ""
var scene_path: String = "res://Scenes/World scenes/blacksmith&butcher/kovacs_inventory_item.tscn"
@onready var icon_sprite = $Sprite2D

var item = {
		"quantity": 1,
		"type": item_type,
		"name": item_name,
		"effect": item_effect,
		"texture": item_texture,
		"scene_path": scene_path,
		"cost": item_cost
	}
