extends Button

@onready var settings = %Settings
@onready var label = %Label
@onready var panel = %Panel


func _on_pressed():
	settings.show()
	get_parent().hide()
	label.hide()
	panel.hide()
	
