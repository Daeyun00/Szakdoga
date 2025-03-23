extends Area2D

var is_player_within_area: bool
var first_interaction : bool

@onready var inventoryUI = $UI
@onready var quitButton = $"../InventoryUI/ColorRect/quit"
@onready var buyInteract = $InteractUI2

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
		Dialogic.start("butch1")
		first_interaction = true
	if event.is_action_pressed("interact") and is_player_within_area and first_interaction == true:
		Dialogic.start("butch2")
	if event.is_action_pressed("Buy") and is_player_within_area:
		if(!Global.is_open_at_blacksmith):
			inventoryUI.visible = true
			buyInteract.visible = true
			Global.is_open_at_blacksmith = true
			if inventoryUI.visible == true:
				buyInteract.visible = false
		else:
			if(inventoryUI.visible == true):
				inventoryUI.visible = false
				Global.is_open_at_blacksmith = false
			else:
				print("Rohadjál mög Sugár Fallosz")
				print(Global.is_open_at_blacksmith)
			
