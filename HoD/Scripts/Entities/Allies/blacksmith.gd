extends Area2D


var is_player_within_area: bool
var first_interaction : bool

@onready var inventoryUI = $"../InventoryUI" 
@onready var quitButton = $"../InventoryUI/ColorRect/Quit"
@onready var buyInteract = $"../InteractUI"
@onready var sellInventory = $"../InventoryUI2"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true
		buyInteract.visible = true
		
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false
		buyInteract.visible = false
		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == false:
		Dialogic.start("blacksmith")
		first_interaction = true
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == true:
		Dialogic.start("blacksmith1")
	


func _on_quit_pressed() -> void:
	inventoryUI.visible = false


func _on_quit_sell_pressed() -> void:
	sellInventory.visible = false
