extends Control

@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu

var is_fight = false
var is_skill = false
var is_item = false
var is_guard = false
var is_flee = false


func _ready() -> void:
	_options_menu.button_focus(0)

func _physics_process(delta: float) -> void:
	if(is_fight):
		if($Allies/Hero.has_focus()):
			$Hostiles/Slime.grab_focus()
	var HeroHP = str($Allies/Hero.HP) + "/" + str($Allies/Hero.MaxHP) + " HP" 
	$Top/Players/Hero_label/Hero_HP_label.text = HeroHP

func _on_v_box_container_button_focused(button: BaseButton) -> void:
	pass

func _on_v_box_container_button_pressed(button: BaseButton) -> void:
	match button.name:
		"Fight_button":
			print("Fight")
			is_fight = !is_fight
			$Top/Players/Hero_label/Hero_status.set_text("Attack")
			_fight_window(button)
		"Skill_button":
			print("Skill")
			is_skill = !is_skill
		"Item_button":
			print("Item")
			is_item = !is_item
		"Guard_button":
			print("Guard")
			is_guard = !is_guard
		"Flee_button":
			print("Flee")
			is_flee = !is_flee
		_:
			print("o_o")

func _fight_window(button: BaseButton):
	button.release_focus()
	$Hostiles/Slime.grab_focus()
	$Options.visible = false
	
