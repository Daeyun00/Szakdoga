extends Control

@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu

func _ready() -> void:
	_options_menu.button_focus(0)

func _on_attack_menu_container_button_focused(button: BaseButton) -> void:
	pass
	
func _on_attack_menu_button_pressed(button: BaseButton) -> void:
	print(button)
