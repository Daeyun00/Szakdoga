extends Control

@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu
@onready var hostile1: Button = $Hostiles/Slime
@onready var hostile2: Button = $Hostiles/Slime2
@onready var hostile3: Button = $Hostiles/Slime3
@onready var usage_panel = $UsagePanel
@onready var details_panel = $DetailsPanel
@onready var hero_inventory = $UsagePanel/HeroButton/HeroInventoryUI
@onready var mage_inventory = $UsagePanel/MageButton/MageInventoryUI
@onready var thief_inventory = $UsagePanel/ThiefButton/ThiefInventoryUI

signal interacted(jezus: bool)

var is_fight = false
var is_skill = false
var is_item = false
var is_guard = false
var is_flee = false

var finished_action = false

var selected_hostile = 0
var slime1_select = false
var slime2_select = false
var slime3_select = false



func _ready() -> void:
	_options_menu.button_focus(0)

func _physics_process(delta: float) -> void:
	if(is_fight):
		if($Allies/Hero.has_focus()):
			hostile1.grab_focus()
	var HeroHP = str($Allies/Hero.HP) + "/" + str($Allies/Hero.MaxHP) + " HP" 
	$Top/Players/Hero_label/Hero_HP_label.text = HeroHP
	if(!is_fight && !is_skill && !is_item && !is_guard && !is_flee):
		if ($Hostiles/Slime.has_focus()):
			$Options/AttackMenu/Flee_button.grab_focus()
	
			
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
			print("Válasszon karaktert! ")
			is_item = !is_item
		"Guard_button":
			print("Guard")
			is_guard = !is_guard
		"Flee_button":
			print("Flee")
			is_flee = !is_flee
		_:
			print("o_o")

func _fight_window(button: BaseButton) -> void:
	button.release_focus()
	hostile1.grab_focus()
	$Options.visible = false
	#nem működik :)
	
	
	print(":3")


#ez se működik valamiért :3

	


func _on_item_button_mouse_entered():
	usage_panel.visible = false
	details_panel.visible = true


func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false


func _on_item_button_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			usage_panel.visible = !usage_panel.visible
	


func _on_hero_button_pressed() -> void:
	hero_inventory.visible = true
	


func _on_mage_button_pressed() -> void:
	mage_inventory.visible = true


func _on_thief_button_pressed() -> void:
	thief_inventory.visible = true
	

func _on_kilep_hero_pressed() -> void:
	hero_inventory.visible = false
	

func _on_kilep_mage_pressed() -> void:
	mage_inventory.visible = false
	


func _on_kilep_thief_pressed() -> void:
	thief_inventory.visible = false
	


func _on_slime_pressed() -> void:
	print("asd")
