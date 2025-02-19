extends Control

#Menus
@onready var _options: WindowDefault = $Options
@onready var _options_menu: Menu = $Options/AttackMenu

#Hostiles
@onready var hostile1: Button = $Hostiles/Slime
@onready var hostile2: Button = $Hostiles/Slime2
@onready var hostile3: Button = $Hostiles/Slime3

#Allies
@onready var Hero: Button = $Allies/Hero
@onready var Mage: Button = $Allies/Mage
@onready var Thief: Button = $Allies/Thief

#idk
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

var turn = 0


func _ready() -> void:
	_options_menu.button_focus(0)

func _physics_process(delta: float) -> void:
	#enemy focus
	if(is_fight):
		if($Allies/Hero.has_focus()):
			hostile1.grab_focus()
	
	#Resource labels
	var HeroHP = str($Allies/Hero.HP) + "/" + str($Allies/Hero.MaxHP) + " HP"
	var SlimeHP = str($Hostiles/Slime.HP) + "/" + str($Hostiles/Slime.MaxHP) + "HP" 
	
	$Top/Enemies/Enemy1/Enemy1_HP_label2.text = SlimeHP
	$Top/Players/Hero_label/Hero_HP_label.text = HeroHP
	
	#Option focus fix
	if(!is_fight && !is_skill && !is_item && !is_guard && !is_flee):
		if (!$Options/AttackMenu/Fight_button.has_focus() and !$Options/AttackMenu/Flee_button.has_focus() and !$Options/AttackMenu/Guard_button.has_focus() and !$Options/AttackMenu/Item_button.has_focus() and !$Options/AttackMenu/Skill_button.has_focus()):
			$Options/AttackMenu/Flee_button.grab_focus()
	
	#Enemy attack
	if(turn > 4):
		turn = 0
func _on_v_box_container_button_focused(button: BaseButton) -> void:
	pass

func _on_v_box_container_button_pressed(button: BaseButton) -> void:
	match button.name:
		"Fight_button":
			print("Fight")
			is_fight = !is_fight
			match turn:
				0:
					$Top/Players/Hero_label/Hero_status.text = "Attack"
				1:
					$Top/Players/Mage_label/Mage_status.text = "Attack"
				2:
					$Top/Players/Thief_label/Thief_status.text = "Attack"
				_:
					print(":3")
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
	if(is_fight):
		match turn:
				0:
					hostile1.HP -= Hero.ATK - hostile1.DEF
					if (Hero.Rage < 100):
						Hero.Rage += 5
					turn += 1
				1:
					hostile1.HP -= Mage.ATK/2 - hostile1.DEF
					turn += 1
				2:
					hostile1.HP -= Thief.ATK - hostile1.DEF
					turn += 1
				_:
					print("o_o")
		hostile1.release_focus()
		$Options.visible = true
		$Options/AttackMenu/Fight_button.grab_focus()
		is_fight = !is_fight
