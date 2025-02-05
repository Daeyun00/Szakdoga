extends Control

@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu

func _ready() -> void:
	_options_menu.button_focus(0)

func _on_v_box_container_button_focused(button: BaseButton) -> void:
	pass
	


func _on_v_box_container_button_pressed(button: BaseButton) -> void:
	match button.name:
		"Fight_button":
			print("Fight")
		"Skill_button":
			print("Skill")
		"Item_button":
			print("Item")
		"Guard_button":
			print("Guard")
		"Flee_button":
			print("Flee")
		_:
			print("o_o")
