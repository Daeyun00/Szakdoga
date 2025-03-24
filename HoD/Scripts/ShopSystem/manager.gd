extends Panel


enum MODE{
	INVENTORY,
	SHOP
}

func _physics_process(delta: float) -> void:
	$Currency/Balance.set_text(str(Global.currency))

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("Inventory"):
		open_mode(MODE.INVENTORY)
	if event.is_action_pressed("shopInteract"):
		open_mode(MODE.SHOP)

func open_mode(mode):
	visible = not visible
	
	match mode:
		MODE.INVENTORY:
			%Shop.visible = false
			if visible:
				print("Inventory mode")
		MODE.SHOP:
			%Shop.visible = true
			if visible:
				print("Shop mode")
