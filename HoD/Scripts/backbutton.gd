extends Button

@onready var menu = %Menu
@onready var settings = %Settings
@onready var label = %Label
@onready var panel = %Panel

func _on_pressed():
	menu.show()
	panel.show()
	label.show()
	settings.hide()
