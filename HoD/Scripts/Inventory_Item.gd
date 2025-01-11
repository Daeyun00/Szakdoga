@tool
extends Node2D

<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
@export var item_type = ""
@export var item_name = ""
@export var item_texture: Texture
@export var item_effect = ""
<<<<<<< Updated upstream
var scene_path: String = "res://Scenes/Inventory_Item.tscn"
@onready var icon_sprite = $Sprite2D 
=======

var scene_path: String = "res://Scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D


>>>>>>> Stashed changes

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
