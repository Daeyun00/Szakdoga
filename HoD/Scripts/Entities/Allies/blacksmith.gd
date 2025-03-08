extends Area2D


var is_player_within_area: bool

@onready var inventoryUI = $"../InventoryUI" 
@onready var quitButton = $"../InventoryUI/ColorRect/Quit"
@onready var buyInteract = $"../InteractUI"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = true
		buyInteract.visible = true
		
		

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_within_area = false
		buyInteract.visible = false
		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_within_area:
		Dialogic.start("blacksmith")
	if event.is_action("Buy") and is_player_within_area:
		inventoryUI.visible = true
		buyInteract.visible = false


func _on_quit_pressed() -> void:
	inventoryUI.visible = false
